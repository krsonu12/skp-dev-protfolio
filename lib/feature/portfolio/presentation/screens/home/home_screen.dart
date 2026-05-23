import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../shared_providers/portfolio_providers.dart';
import '../../shared_providers/ui_providers.dart';
import '../../widgets/nav_bar.dart';
import '../about/about_section.dart';
import '../contact/contact_section.dart';
import '../experience/experience_section.dart';
import '../projects/projects_section.dart';
import '../skills/skills_section.dart';
import 'hero_section.dart';

// ---------------------------------------------------------------------------
// Section keys — module-level so they survive widget rebuilds
// ---------------------------------------------------------------------------
final _heroKey = GlobalKey();
final _aboutKey = GlobalKey();
final _experienceKey = GlobalKey();
final _projectsKey = GlobalKey();
final _skillsKey = GlobalKey();
final _contactKey = GlobalKey();

final _sectionKeys = [
  _aboutKey, // index 0 → ABOUT
  _experienceKey, // index 1 → EXPERIENCE
  _projectsKey, // index 2 → PROJECTS
  _skillsKey, // index 3 → SKILLS
  _contactKey, // index 4 → CONTACT
];

// ---------------------------------------------------------------------------
// HomeScreen
// ConsumerStatefulWidget: scroll listener attached once in initState,
// ScrollController owned by State (not a provider) so it is never disposed
// by a theme change mid-animation. Zero setState.
// ---------------------------------------------------------------------------
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Owned here — created once, disposed once, survives theme rebuilds.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    const threshold = 120.0;

    // Find the RenderBox of the scroll viewport to use as ancestor,
    // so localToGlobal gives us coordinates relative to the viewport origin
    // (not the screen). This makes the math correct regardless of where
    // the Scaffold sits on screen.
    final scrollCtx = _scrollController.position.context.storageContext;
    final viewportBox = scrollCtx.findRenderObject() as RenderBox?;

    int activeIndex = -1;

    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      // Position relative to the viewport widget — this gives us the
      // section's current on-screen Y. Adding scrollOffset converts it
      // to the section's absolute Y in the scroll content.
      final localDy = viewportBox != null
          ? box.localToGlobal(Offset.zero, ancestor: viewportBox).dy
          : box.localToGlobal(Offset.zero).dy;
      final absoluteTop = localDy + scrollOffset;

      // A section is "active" if its top has passed the threshold line.
      if (absoluteTop <= scrollOffset + threshold) {
        activeIndex = i; // keep updating — last one that qualifies wins
      }
    }

    if (ref.read(activeSectionProvider) != activeIndex) {
      ref.read(activeSectionProvider.notifier).state = activeIndex;
    }
  }

  void _scrollToSection(int index) {
    if (!_scrollController.hasClients) return;

    // Immediately highlight the tapped tab — don't wait for scroll to settle.
    if (index >= 0 && index < _sectionKeys.length) {
      ref.read(activeSectionProvider.notifier).state = index;
    } else if (index == -1) {
      ref.read(activeSectionProvider.notifier).state = -1;
    }

    if (index == -1) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    if (index < _sectionKeys.length) {
      final ctx = _sectionKeys[index].currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
          alignment: 0.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolioState = ref.watch(portfolioNotifierProvider);
    final activeSection = ref.watch(activeSectionProvider);

    return Scaffold(
      backgroundColor: context.bgColor,
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64), // nav bar spacer

                SizedBox(
                  key: _heroKey,
                  child: HeroSection(
                    onCtaTap: () => _scrollToSection(0),
                  ),
                ),

                SizedBox(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                SizedBox(
                  key: _experienceKey,
                  child: portfolioState.portfolio != null
                      ? ExperienceSection(
                          experiences: portfolioState.portfolio!.experiences,
                        )
                      : const _LoadingSection(),
                ),

                SizedBox(
                  key: _projectsKey,
                  child: portfolioState.portfolio != null
                      ? ProjectsSection(
                          projects: portfolioState.portfolio!.projects,
                        )
                      : const _LoadingSection(),
                ),

                SizedBox(
                  key: _skillsKey,
                  child: portfolioState.portfolio != null
                      ? SkillsSection(
                          skillCategories:
                              portfolioState.portfolio!.skillCategories,
                          highlights: portfolioState.portfolio!.highlights,
                        )
                      : const _LoadingSection(),
                ),

                SizedBox(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // ── Sticky nav bar ──────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              activeIndex: activeSection,
              onTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loading placeholder
// ---------------------------------------------------------------------------
class _LoadingSection extends ConsumerWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          color: context.accentColor,
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
