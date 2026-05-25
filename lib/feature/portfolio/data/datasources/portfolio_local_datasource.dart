import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_category_entity.dart';

class PortfolioLocalDataSource {
  const PortfolioLocalDataSource();

  PortfolioEntity getPortfolioData() {
    return const PortfolioEntity(
      experiences: _experiences,
      projects: _projects,
      skillCategories: _skillCategories,
      highlights: _highlights,
    );
  }

  // ── Experiences ────────────────────────────────────────────────────────────
  static const List<ExperienceEntity> _experiences = [
    ExperienceEntity(
      company: 'Webskitters Technology Solutions Pvt. Ltd.',
      location: 'Kolkata',
      role: 'Senior Flutter Developer',
      period: 'Oct 2025 – Apr 2026',
      bullets: [
        'Architected and owned a white-label community platform SDK, enabling 10+ client brands to deploy customized mobile apps from a single codebase — reducing per-client delivery time by ~60%.',
        'Led architecture design sessions adopting Clean Architecture + BLoC, establishing team-wide patterns for feature isolation, dependency injection (GetIt), and scalable data layers.',
        'Defined and enforced Flutter best practices through structured code reviews; introduced automated lint rules (flutter_lints, custom_lint) and pre-commit hooks to enforce consistency across 6 developers.',
        'Conducted requirement-gathering workshops with product stakeholders, translating functional specs into technical ADRs and sprint-ready task breakdowns.',
        'Mentored 3 junior developers through pair-programming sessions focused on reactive patterns, widget lifecycle, and performance profiling with Flutter DevTools.',
        'Integrated Firebase Crashlytics + Performance Monitoring to achieve < 0.1% crash-free session rate; resolved memory leaks identified via heap snapshot analysis.',
      ],
    ),
    ExperienceEntity(
      company: 'Creativebuzz Solution Pvt. Ltd.',
      location: 'Ghaziabad',
      role: 'Senior Flutter Developer',
      period: 'Nov 2024 – Sep 2025',
      projectName: 'AI-Powered Healthcare Document Reader',
      bullets: [
        'Owned full-stack mobile architecture for an AI document processing app: built Flutter client communicating with AWS Textract (OCR) + custom NLP models for healthcare form extraction and auto-enrollment.',
        'Designed an offline-first pipeline using Hive + background isolates to process large PDF documents without blocking the UI thread, reducing perceived latency by ~40%.',
        'Integrated AWS SageMaker inference endpoints with Dio interceptors, implementing retry logic, token refresh, and exponential backoff for unreliable field-network conditions.',
        'Built a custom form-rendering engine in Flutter that dynamically generated validated input widgets from backend-driven JSON schemas — eliminating hardcoded UI for 20+ document types.',
      ],
    ),
    ExperienceEntity(
      company: 'Creativebuzz Solution Pvt. Ltd.',
      location: 'Ghaziabad',
      role: 'Senior Flutter Developer',
      period: 'Nov 2024 – Sep 2025',
      projectName: 'Multi-Modal Logistics Scanner App',
      bullets: [
        'Delivered a production logistics app for multi-modal transport using Flutter + Firebase + custom REST APIs; shipped to Play Store and App Store with 4.5+ ratings.',
        'Implemented real-time shipment tracking via Firestore streams with optimistic UI updates — ensuring UI consistency even during intermittent connectivity.',
        'Architected QR/barcode scanning pipeline with ML Kit integration, batching scanned events into atomic Firestore writes to prevent data races in high-throughput warehouse scenarios.',
        'Configured end-to-end CI/CD with GitHub Actions + Fastlane: automated build numbering, code signing, staging/production flavors, and Firebase App Distribution rollouts.',
      ],
    ),
    ExperienceEntity(
      company: 'Cookytech Technology Pvt. Ltd.',
      location: 'Ranchi',
      role: 'Associate Flutter Developer',
      period: 'Jul 2021 – Nov 2024',
      bullets: [
        'Contributed to 5+ production apps across food-tech and e-commerce domains; owned full feature modules including cart, checkout, and loyalty rewards with unit and widget test coverage > 70%.',
        'Migrated a legacy stateful widget codebase to BLoC pattern, reducing setState calls by 80% and making 15+ screens independently testable.',
        'Integrated third-party SDKs (Razorpay, Google Maps, Push Notifications) with abstraction layers to allow seamless provider swaps without client-code changes.',
        'Improved cold start time by 35% through deferred component loading, image caching strategy (cached_network_image), and build optimization (--split-debug-info, --obfuscate).',
      ],
    ),
  ];

  // ── Projects ───────────────────────────────────────────────────────────────
  static const List<ProjectEntity> _projects = [
    ProjectEntity(
      iconKey: 'label_outline',
      title: 'White-Label Community Platform SDK',
      description:
          'A multi-tenant SDK enabling 10+ client brands to ship customized community apps from a single Flutter codebase.',
      tags: ['Flutter', 'Clean Architecture', 'BLoC', 'GetIt', 'Firebase'],
      bullets: [
        'Reduced per-client delivery time by ~60% via runtime theming and feature-flag system.',
        'Established team-wide patterns for feature isolation and scalable data layers.',
        'Integrated Firebase Crashlytics achieving < 0.1% crash-free session rate.',
      ],
    ),
    ProjectEntity(
      iconKey: 'local_hospital_outlined',
      title: 'AI-Powered Healthcare Document Reader',
      description:
          'Flutter app integrating AWS Textract + NLP models for automated healthcare form extraction and patient auto-enrollment.',
      tags: ['Flutter', 'AWS Textract', 'SageMaker', 'Hive', 'Dio'],
      bullets: [
        'Offline-first pipeline with background isolates reduced perceived latency by ~40%.',
        'Dynamic form-rendering engine from JSON schemas eliminated hardcoded UI for 20+ document types.',
        'Exponential backoff + retry logic for unreliable field-network conditions.',
      ],
    ),
    ProjectEntity(
      iconKey: 'local_shipping_outlined',
      title: 'Multi-Modal Logistics Scanner App',
      description:
          'Production logistics app for multi-modal transport with real-time tracking, QR/barcode scanning, and CI/CD automation.',
      tags: ['Flutter', 'Firebase', 'ML Kit', 'Fastlane', 'GitHub Actions'],
      bullets: [
        'Shipped to Play Store and App Store with 4.5+ ratings.',
        'Real-time Firestore streams with optimistic UI for intermittent connectivity.',
        'Atomic Firestore writes prevent data races in high-throughput warehouse scenarios.',
      ],
      storeRating: '4.5+',
    ),
    ProjectEntity(
      iconKey: 'shopping_cart_outlined',
      title: 'Food-Tech & E-Commerce Suite',
      description:
          'Suite of 5+ production apps across food-tech and e-commerce with cart, checkout, loyalty rewards, and payment integrations.',
      tags: ['Flutter', 'BLoC', 'Razorpay', 'Google Maps', 'FCM'],
      bullets: [
        'Unit and widget test coverage > 70% across all feature modules.',
        'Migrated legacy stateful widgets to BLoC, reducing setState calls by 80%.',
        'Improved cold start time by 35% via deferred loading and build optimization.',
      ],
    ),
  ];

  // ── Skill categories ───────────────────────────────────────────────────────
  static const List<SkillCategoryEntity> _skillCategories = [
    SkillCategoryEntity(
      category: 'Architecture',
      iconKey: 'account_tree_outlined',
      skills: [
        'Clean Architecture',
        'Feature-First Modularization',
        'Domain-Driven Design',
        'SOLID + OOPs',
        'Melos Monorepo'
      ],
    ),
    SkillCategoryEntity(
      category: 'State Management',
      iconKey: 'bolt_outlined',
      skills: ['BLoC', 'MobX + GetIt', 'Riverpod', 'Provider', 'GetX'],
    ),
    SkillCategoryEntity(
      category: 'Networking',
      iconKey: 'language_outlined',
      skills: [
        'REST APIs',
        'Dio + Retrofit',
        'Freezed / json_serializable',
        'GraphQL basics',
        'Interceptors & Retry'
      ],
    ),
    SkillCategoryEntity(
      category: 'Backend / Cloud',
      iconKey: 'cloud_outlined',
      skills: [
        'Firebase (Firestore, Auth, FCM, Crashlytics)',
        'Supabase',
        'AWS Textract',
        'AWS SageMaker',
        'AWS S3'
      ],
    ),
    SkillCategoryEntity(
      category: 'CI/CD & DevOps',
      iconKey: 'rocket_launch_outlined',
      skills: [
        'GitHub Actions',
        'Codemagic',
        'Fastlane',
        'Firebase App Distribution',
        'Play Console / TestFlight'
      ],
    ),
    SkillCategoryEntity(
      category: 'Testing',
      iconKey: 'science_outlined',
      skills: [
        'Unit & Widget Tests',
        'Integration Tests',
        'flutter_test',
        'mockito / bloc_test',
        'integration_test'
      ],
    ),
    SkillCategoryEntity(
      category: 'Data & Storage',
      iconKey: 'storage_outlined',
      skills: [
        'Hive',
        'SQLite (sqflite)',
        'SharedPreferences',
        'Secure Storage',
        'File System'
      ],
    ),
    SkillCategoryEntity(
      category: 'Tooling',
      iconKey: 'build_outlined',
      skills: [
        'Flutter & Dart',
        'Git / GitHub / GitLab',
        'Figma',
        'VS Code / Android Studio',
        'Postman / Swagger'
      ],
    ),
  ];

  // ── Highlights ─────────────────────────────────────────────────────────────
  static const List<String> _highlights = [
    'Modular Monorepo Design with melos — shared domain, data, and feature packages enabling parallel team development.',
    'State Management Philosophy — BLoC for event-driven logic, MobX+GetIt for service-locator patterns, Riverpod for fine-grained reactivity.',
    'Offline-First Architecture — Hive + Firestore change streams with conflict resolution for low-connectivity environments.',
    'Performance Engineering — Flutter DevTools profiling; const constructors, RepaintBoundary, ListView.builder across large list UIs.',
    'Security-First Development — certificate pinning, flutter_secure_storage, ProGuard obfuscation, OWASP Mobile Top 10.',
  ];
}
