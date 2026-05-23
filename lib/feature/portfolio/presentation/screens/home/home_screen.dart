import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/theme_ext.dart';
import '../../shared_providers/portfolio_providers.dart';
import '../../widgets/nav_bar.dart';
import '../about/about_section.dart';
import '../contact/contact_section.dart';
import '../experience/experience_section.dart';
import '../projects/projects_section.dart';
import '../skills/skills_section.dart';
import 'hero_section.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll-to navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  int _activeSection = -1;

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
    // Update active nav item based on scroll position
    final offset = _scrollController.offset;
    final keys = [
      _aboutKey,
      _experienceKey,
      _projectsKey,
      _skillsKey,
      _contactKey,
    ];

    for (var i = keys.length - 1; i >= 0; i--) {
      final ctx = keys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          if (offset + 100 >= pos.dy + _scrollController.offset) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            return;
          }
        }
      }
    }
    if (_activeSection != -1) setState(() => _activeSection = -1);
  }

  void _scrollToSection(int index) {
    final keys = [
      _aboutKey,
      _experienceKey,
      _projectsKey,
      _skillsKey,
      _contactKey,
    ];

    if (index == -1) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    if (index < keys.length) {
      final ctx = keys[index].currentContext;
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
    final state = ref.watch(portfolioNotifierProvider);

    return Scaffold(
      backgroundColor: context.bgColor,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nav bar height spacer
                const SizedBox(height: 64),

                // Hero
                SizedBox(
                    key: _heroKey,
                    child: HeroSection(
                      onCtaTap: () => _scrollToSection(1),
                    )),

                // About
                SizedBox(key: _aboutKey, child: const AboutSection()),

                // Experience
                SizedBox(
                  key: _experienceKey,
                  child: state.portfolio != null
                      ? ExperienceSection(
                          experiences: state.portfolio!.experiences,
                        )
                      : const _LoadingSection(),
                ),

                // Projects
                SizedBox(
                  key: _projectsKey,
                  child: state.portfolio != null
                      ? ProjectsSection(
                          projects: state.portfolio!.projects,
                        )
                      : const _LoadingSection(),
                ),

                // Skills
                SizedBox(
                  key: _skillsKey,
                  child: state.portfolio != null
                      ? SkillsSection(
                          skillCategories: state.portfolio!.skillCategories,
                          highlights: state.portfolio!.highlights,
                        )
                      : const _LoadingSection(),
                ),

                // Contact
                SizedBox(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // Sticky nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              activeIndex: _activeSection,
              onTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) {
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
