<!-- SPDX-License-Identifier: Apache-2.0 -->
# Contributing to APIS

Thank you for your interest in contributing to APIS! We welcome contributions from the community to help improve and grow this project.

## How to Contribute

### Reporting Issues

If you encounter any bugs, have feature requests, or want to suggest improvements, please open an issue in the relevant sub-repository under the [Hyphae organization](https://github.com/hyphae). When filing an issue, please provide:

- A clear title and description
- Steps to reproduce (if applicable)
- Expected and actual behavior
- Any relevant logs or screenshots

### Contributing Code

The main repository (APIS) does not contain code directly but serves as the build orchestrator for the following sub-repositories:

- [apis-bom](https://github.com/hyphae/apis-bom)
- [apis-ccc](https://github.com/hyphae/apis-ccc)
- [apis-common](https://github.com/hyphae/apis-common)
- [apis-emulator](https://github.com/hyphae/apis-emulator)
- [apis-log](https://github.com/hyphae/apis-log)
- [apis-main](https://github.com/hyphae/apis-main)
- [apis-main_controller](https://github.com/hyphae/apis-main_controller)
- [apis-service_center](https://github.com/hyphae/apis-service_center)
- [apis-tester](https://github.com/hyphae/apis-tester)
- [apis-web](https://github.com/hyphae/apis-web)

Each of these sub-repositories may have different contribution requirements based on the technology stack (Java, Groovy or Python). Please refer to their respective README.md files.

#### 1. Fork the Relevant Repository

Start by forking and cloning the repository you wish to contribute to.

```bash
# Fork the repository and clone it locally.  Example for apis-common
git clone https://github.com/hyphae/apis-common.git
cd apis-common
```

#### 2. Create a Branch

Create a new branch for your work:

```bash
git checkout -b feature-branch
```

#### 3. Implement Changes

Make your changes following the coding standards of the project. Ensure your code is well-documented and includes tests where applicable.

#### 4. Run Tests

Before submitting your changes, make sure to test them:

```bash
mvn test   # Java projects
```

#### 5. Commit Changes

Follow the project’s commit message conventions. A good commit message format is:

```text
[Type] Short description

Detailed explanation of the changes (if necessary)
```

Examples:

```text
[Fix] Corrected validation logic for job assignments
[Feature] Added new user role permissions
```

#### 6. Submit a Pull Request (PR)

Push your changes to your fork and create a pull request against the `main` branch of the repository. Provide a detailed explanation of the changes in the PR description.

### Code Review Process

All contributions go through a code review process:

1. A maintainer will review your PR and may request changes.
2. Once approved, your changes will be merged into the main branch.
3. If necessary, your changes will be included in the next release.

### Contribution Guidelines

- Follow the project’s coding style and conventions.
- Ensure changes do not introduce security vulnerabilities.
- Write clear and descriptive commit messages.
- Be respectful and constructive in discussions and code reviews.

### Community Contributions

In addition to code, you can contribute by:

- Writing and improving documentation.
- Helping answer questions in discussions and issues.
- Reporting bugs and suggesting features.

Thank you for contributing to APIS! 🚀
