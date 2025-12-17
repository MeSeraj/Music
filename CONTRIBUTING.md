# Contributing to Music Player

Thank you for your interest in contributing to the Music Player project! This document provides guidelines and instructions for contributing.

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Git
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Setting Up Development Environment

1. Fork and clone the repository:
```bash
git clone https://github.com/MeSeraj/Music.git
cd Music
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

4. Run tests:
```bash
flutter test
```

## Development Workflow

### Branch Naming Convention

- Feature: `feature/feature-name`
- Bug Fix: `bugfix/issue-description`
- Hotfix: `hotfix/issue-description`

### Code Style

This project follows the official Dart style guide. We use `flutter_lints` for linting.

Run the analyzer before committing:
```bash
flutter analyze
```

Format your code:
```bash
flutter format .
```

### Commit Messages

Use clear and descriptive commit messages:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding or updating tests
- `chore:` for maintenance tasks

Example:
```
feat: add shuffle play mode
fix: resolve audio playback issue on Android
docs: update README with new features
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

- Write unit tests for business logic
- Write widget tests for UI components
- Ensure all new features have corresponding tests

## Pull Request Process

1. Create a new branch for your feature/fix
2. Make your changes and commit them
3. Write/update tests as needed
4. Run `flutter analyze` and fix any issues
5. Run `flutter test` and ensure all tests pass
6. Push your branch and create a pull request
7. Describe your changes clearly in the PR description
8. Wait for code review and address feedback

## Code Review Guidelines

Reviewers will check for:

- Code quality and readability
- Adherence to style guidelines
- Test coverage
- Documentation
- Performance considerations
- Security issues

## Areas for Contribution

### High Priority

- [ ] Background audio playback
- [ ] Media notification controls
- [ ] Playlist creation and management
- [ ] Search functionality
- [ ] Audio metadata extraction

### Nice to Have

- [ ] Shuffle and repeat modes
- [ ] Equalizer
- [ ] Sleep timer
- [ ] Lyrics display
- [ ] Theme customization
- [ ] Multiple language support

## Reporting Issues

When reporting issues, please include:

- Clear description of the issue
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)
- Device/Platform information
- Flutter version

## Questions?

Feel free to open an issue with the `question` label if you need help or clarification.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
