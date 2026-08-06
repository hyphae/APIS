# Governance Policy for APIS

## 1. Overview and Scope

The **APIS** project aims to build and maintain high-quality open source software in the energy and sustainability domain. This document outlines the governance structure, roles, decision-making processes, and policies that guide the project.

Our governance model is designed to be transparent, inclusive, and community-driven, ensuring that decisions are made in the best interest of the project's long-term health. We adhere to the principles of "lazy consensus" for most decisions and prioritize open communication.

This project operates under the auspices of **Hyphae** and, where applicable, aligns with the standards of the **LF Energy** foundation. All community members must adhere to our [Code of Conduct](CODE_OF_CONDUCT.md).

## 2. Roles and Responsibilities

The project acknowledges several levels of involvement and responsibility. These roles are fluid, and members are encouraged to progress through them as their involvement deepens.

### 2.1 Users and Community Members
Users are community members who use the software, provide feedback, report bugs, or participate in discussions.
*   **Responsibilities:**
    *   Adhere to the Code of Conduct.
    *   Report bugs and usage issues via GitHub Issues.
    *   Participate in community discussions (e.g., Slack, Mailing Lists, GitHub Discussions).

### 2.2 Contributors
Contributors are community members who submit patches, documentation, or other concrete contributions to the project.
*   **Responsibilities:**
    *   Sign the required Developer Certificate of Origin (DCO) or CLA if applicable.
    *   Follow the [contribution guidelines](CONTRIBUTING.md).
    *   Address feedback on their Pull Requests (PRs).
*   **Privileges:**
    *   Contributors are listed in the project credits or contributors file.
    *   Frequent contributors may be nominated for Maintainer status.

### 2.3 Maintainers
Maintainers are contributors who have dedicated significant time to the project and have demonstrated a strong understanding of its codebase and goals. They have write access to the repository.
*   **Responsibilities:**
    *   Triage incoming issues and pull requests.
    *   Review and merge code submissions from contributors.
    *   Ensure code quality, testing, and documentation standards are met.
    *   Mentor new contributors.
    *   Participate in roadmap planning.
*   **Privileges:**
    *   Write access to the repository (ability to tag issues, manage labels, merge PRs).
    *   Voting rights on technical decisions.

### 2.4 Project Steering Committee (PSC) / Project Owners
The Project Steering Committee (PSC) represents the technical leadership of the project. This group consists of Project Owners who are responsible for the overall strategic direction, governance, and final arbitration of decisions.
*   **Responsibilities:**
    *   Set the long-term roadmap and vision for the project.
    *   Make decisions on sensitive matters (e.g., security, conduct violations).
    *   Nominate and approve new Maintainers and PSC members.
    *   Ensure the project remains compliant with LF Energy / Hyphae policies.
    *   Manage access credentials and repository settings.
*   **Privileges:**
    *   Administrator access to the repository and associated infrastructure (e.g., package registries, cloud resources).
    *   Final say in deadlock situations.

## 3. Decision-Making Process

We value transparent decision-making. All technical and governance decisions should be discussed publicly in GitHub Issues, Pull Requests, or public mailing lists/channels.

### 3.1 Consensus Seeking
The primary mode of decision-making is "consensus seeking."
*   Proposals are made via GitHub Issues or PRs.
*   Discussion is open for a reasonable period (typically 3-7 days, depending on impact).
*   If no valid objections are raised, the proposal is considered accepted.

### 3.2 Lazy Consensus
To maintain velocity, we use "Lazy Consensus" for standard operational tasks (e.g., merging code, minor refactors).
*   A maintainer proposes a change (often by submitting a PR).
*   If no other maintainer objects within a set timeframe (e.g., 24-72 hours), the change is assumed to be supported and can be merged.
*   Silence is consent.

### 3.3 Voting
If consensus cannot be reached through discussion, the PSC may call for a formal vote.
*   **Quorum:** A simple majority of current PSC members constitutes a quorum.
*   **Passing Vote:** Simple majority (more than 50%) of the votes cast is required for approval.
*   **Tie-Breaking:** In the event of a tie, the <PROJECT LEAD OR COMMITTEE CHAIR> (or a random selection processes if no Chair exists) casts the deciding vote.

### 3.4 Handling Disagreements and Escalation
Disagreements are natural. When they occur:
1.  Focus on technical merits and project goals, not personalities.
2.  If a resolution cannot be found between contributors, a Maintainer should mediate.
3.  If the issue remains unresolved, it is escalated to the PSC for a final decision.

## 4. Committer and Maintainer Lifecycle

The health of the project depends on an active and engaged set of maintainers.

### 4.1 Becoming a Maintainer
*   **Nomination:** Any existing Maintainer or PSC member can nominate an active Contributor for maintainership. Nominations should be sent to the PSC via <PRIVATE MAILING LIST OR EMAIL>.
*   **Criteria:** Nominations are based on the quality of contributions (code, docs, triage) and the individual's interaction with the community (helpfulness, tone).
*   **Approval:** The PSC votes on the nomination. Consensus is preferred, but a majority vote is sufficient.

### 4.2 Expectations for Activity
Maintainers are expected to remain active. "Active" is loosely defined as interacting with the project (committing, reviewing, commenting) at least once every 3 months.

### 4.3 Emeritus and Retirement
*   **Voluntary Retirement:** A Maintainer can step down at any time by notifying the PSC. They will be listed as an "Emeritus Maintainer" to honor their past contributions.
*   **Inactivity:** Maintainers who are inactive for more than 6 months may be moved to Emeritus status to accurately reflect the current active team. This is not punitive; they can be reinstated upon returning to activity.
*   **Removal:** In rare cases of severe Code of Conduct violations or actions detrimental to the project, the PSC may vote to remove a Maintainer. This requires a 2/3 majority vote by the PSC.

## 5. Release and Roadmap Governance

### 5.1 Roadmap
The project roadmap is a living document, typically tracked in GitHub Projects or a `ROADMAP.md` file.
*   Suggestions for major features or direction changes are proposed via dedicated "RFC" (Request for Comments) issues.
*   The PSC reviews and approves major roadmap items to ensure alignment with project goals and resource availability.

### 5.2 Releases
*   **Cadence:** The project follows [Semantic Versioning](https://semver.org/). Release cadence is determined by the availability of features and fixes.
*   **Approval:** A designated Release Manager (chosen from the Maintainers) or a PSC member must approve the final release build.
*   **Process:** The release process is documented in `RELEASE.md` (if available) or the project wiki.

## 6. Security and Responsible Disclosure

Security is a top priority. We strive to fix vulnerabilities rapidly and transparently.

*   **Reporting:** Do not file public issues for security vulnerabilities. Please report potential vulnerabilities privately to <SECURITY CONTACT EMAIL>.
*   **Response:** The maintainers will acknowledge the report within 48 hours and provide a timeline for triage and resolution.
*   **Disclosure:** A public disclosure will be made only after a patch has been released and users have had reasonable time to upgrade.

## 7. Amendments to this Governance Policy

This governance document acts as a constitution for the project, but it is not immutable.

*   **Proposal:** Changes to `GOVERNANCE.md` must be submitted as a Pull Request.
*   **Approval:** Governance changes require an explicit approval (not just lazy consensus) from a 2/3 majority of the established Project Steering Committee.
*   **Notification:** Significant changes to governance structure will be announced to the community via <MAILING LIST OR ANNOUNCEMENT CHANNEL>.
