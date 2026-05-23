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
// Section keys — module-level constants, survive rebuilds
// ---------------------------------------------------------------------------
final _heroKey = GlobalKey();
final _aboutKey = GlobalKey();
final _experienceKey = GlobalKey();
final _projectsKey = GlobalKey();
final _skillsKey = GlobalKey();
final _contactKey = GlobalKey();

/// Ordered list matching nav indices 0-4.
final _sectionKeys = [
  _aboutKey,
  _experienceKey,
  _projectsKey,
  _skillsKey,
  _contactKey,
];

// ---------------------------------------------------------------------------
// Providers — scoped to this screen
// ---------------------------------------------------------------------------

/// Single ScrollController instance, disposed with the provider.
final _scrollControllerProvider = Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

// ---------------------------------------------------------------------------
// HomeScreen — ConsumerStatefulWidget so the scroll listener is attached
// exactly once in initState and torn down in dispose. Zero setState.
// ---------------------------------------------------------------------------
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Read (not watch) so we don't rebuild when the controller changes.
    _scrollController = ref.read(_scrollControllerProvider);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  /// Determines which section is currently in view by comparing each
  /// section's absolute offset in the scroll content against the current
  /// scroll position. Uses [RenderBox.localToGlobal] with the scroll
  /// viewport's render object as the ancestor so we get content-relative
  /// coordinates, not screen-relative ones.
  void _onScroll() {
    final scrollOffset = _scrollController.offset;

    // Walk sections from bottom to top; first one whose top is above the
    // "active threshold" (100 px from viewport top) wins.
    for (var i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      // Get the section's top position relative to the scroll content,
      // not the screen — subtract the current scroll offset from the
      // screen-relative dy to get the content-relative position.
      final screenDy = box.localToGlobal(Offset.zero).dy;
      final contentTop = screenDy + scrollOffset;

      if (scrollOffset + 120 >= contentTop) {
        final current = ref.read(activeSectionProvider);
        if (current != i) {
          ref.read(activeSectionProvider.notifier).state = i;
        }
        return;
      }
    }

    // Above all sections — deselect.
    if (ref.read(activeSectionProvider) != -1) {
      ref.read(activeSectionProvider.notifier).state = -1;
    }
  }

  void _scrollToSection(int index) {
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
          // ── Scrollable content ────────────────────────────────────────
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

          // ── Sticky nav bar ────────────────────────────────────────────
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
