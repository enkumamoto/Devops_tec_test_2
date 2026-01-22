# DevOps Technical Test

## Objective

Deploy a generic web application stack of your choice on a cloud provider. The solution must be automated to provide a minimal working infrastructure including:

- Automated deployment for application changes/updates.
- Administrative management of the running application.

It is expected that a bastion host is used to access application resources without interference to the application execution. Such host settings must be managed using Puppet to configure at least:

- Administrative user credentials.
- A database management tool (e.g., pgAdmin or phpMyAdmin).

## Rules and Constraints

- **Source Control:** The codebase must be hosted on GitHub or GitLab.
- **Database:** Must run on its own cloud resource and be resilient to application updates.
- **Execution:** The application must run using Docker containers.
- **Automation:** Both infrastructure and application deployment must use CI/CD.
- **Bastion Host:**
  - Must **NOT** run on a publicly reachable network.
  - Must **NOT** host the application database.
  - **MUST** use Puppet to manage system users.
  - **MUST** host non-critical tools (e.g., pgAdmin).

## Deliverables

- Gitlab/Github repository(ies) of:
  - The web application
  - Dockerfiles (including entrypoint scripts)
  - Puppet code
  - Any other related piece of code
- Infrastructure diagram
- Usage guidelines for:
  - Application developers
  - Administrator users
