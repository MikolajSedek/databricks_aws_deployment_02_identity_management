# AI Assistant Guidelines & Sources of Truth

This project deploys AWS infrastructure for **Enterprise Databricks** using a **Hub and Spoke Firewall Architecture** via Terraform. When generating, reviewing, or modifying Terraform code, architecture, or AWS/Databricks configurations, strictly adhere to the following guidelines and authoritative sources of truth.

---

## 1. Project Context & Architectural Goal

- **Objective**: Provision an enterprise-grade AWS network and security foundation for Databricks E2 workspaces using a **Hub and Spoke** architecture with centralized firewall inspection (AWS Network Firewall / Transit Gateway).
- **Core Reference Architecture**: Follow the official Databricks guide on [AWS E2 Firewall Hub and Spoke Architecture](https://github.com/databricks/terraform-provider-databricks/blob/main/docs/guides/aws-e2-firewall-hub-and-spoke.md).
- **Base Repository Template**: Use [https://github.com/MikolajSedek/databricks_aws_deployment_01_vpc_networking](https://github.com/MikolajSedek/databricks_aws_deployment_01_vpc_networking) as the mandatory base template for all new repositories (see [Section 6](#6-repository-scaffolding-module-architecture--operational-guardrails)).

---

## 2. Authoritative Sources of Truth

Always ground implementations in official, up-to-date documentation. Do not rely on assumptions or potentially outdated training data when designing AWS architecture or writing Terraform resource definitions.

### A. Databricks AWS Official Documentation *(Imperative Sources of Truth)*
- **Databricks AWS Workspace Provisioning Skill (`databricks-aws-workspace`)**:
  - Use the vendored skill at [`.github/skills/databricks-aws-workspace/SKILL.md`](./skills/databricks-aws-workspace/SKILL.md) for architecting, provisioning, configuring, and troubleshooting Databricks Workspaces on AWS with Terraform (both Classic Customer-Managed VPC and Serverless compute modes).
- **Databricks AWS Workspace Provisioning Guide**:
  - [Databricks AWS Workspace Terraform Guide](https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/aws-workspace#databricks-workspace) *(Authoritative step-by-step guide for deploying Databricks E2 workspaces with VPC, root bucket, cross-account IAM role, and provider authentication)*
- **Databricks on AWS Workspace Administration Guide**:
  - [Databricks on AWS Workspace Administration Guide](https://docs.databricks.com/aws/en/admin/workspace/) *(Authoritative reference for workspace lifecycle, choosing between serverless and classic workspaces, account console configuration, and operational updates)*
- **Databricks Terraform Provider Official Documentation**:
  - [Databricks Terraform Registry Docs](https://registry.terraform.io/providers/databricks/databricks/latest/docs) *(Authoritative schema and reference for all Databricks Terraform provider resources, data sources, and authentication attributes)*
- **Databricks Cloud Automation Best Practices**:
  - [Automating Databricks Deployments on AWS Best Practices (Part 3)](https://www.databricks.com/blog/best-practices-and-guidance-cloud-engineers-deploy-databricks-aws-part-3) *(Authoritative architectural guidance on 3-tier API endpoints: AWS, Databricks Account, and Databricks Workspace; decoupling modules, and automation guardrails)*
- **Databricks on AWS Official Documentation**:
  - [Databricks on AWS Documentation](https://docs.databricks.com/aws/en/) *(Imperative source of truth for all Databricks AWS configurations, architecture, security, compute, storage, and networking requirements)*
- **Databricks Agent Skill (`databricks-docs`)**:
  - Use the vendored skill at [`.github/skills/databricks-docs/SKILL.md`](./skills/databricks-docs/SKILL.md) to reference the Databricks `llms.txt` index (`https://docs.databricks.com/llms.txt`) when a topic is not fully covered in project modules or direct Databricks docs navigation.
- **Official Databricks GitHub Repositories**:
  - [Official Databricks GitHub Repositories](https://github.com/orgs/databricks/repositories?type=all) *(Authoritative source for official Databricks reference solutions, blueprints, tools, examples, and Terraform providers)*
- **Databricks Terraform Provider Examples**:
  - [Databricks Terraform Provider Examples](https://github.com/databricks/terraform-databricks-examples) *(Extra source of information with examples of using Databricks Terraform provider; when deploying with AWS, use only AWS examples)*
- **Hub & Spoke Firewall Guide**:
  - [Databricks AWS E2 Firewall Hub and Spoke Guide](https://github.com/databricks/terraform-provider-databricks/blob/main/docs/guides/aws-e2-firewall-hub-and-spoke.md)
- **Databricks Customer-Managed VPC**:
  - [Databricks Customer-Managed VPC Configuration Guide](https://docs.databricks.com/aws/en/administration-guide/cloud-configurations/aws/customer-managed-vpc)

### B. AWS Official Documentation
- **AWS Documentation MCP Server (`aws-docs`)**:
  - Use `search_documentation`, `read_documentation`, `read_sections`, and `recommend` to verify service limits, IAM policy requirements, encryption specifications, networking constraints (VPC, Transit Gateway, Network Firewall), and Well-Architected Framework guidelines.
- **Web Documentation**:
  - [AWS Official Documentation](https://docs.aws.amazon.com/)
  - [AWS Network Firewall Developer Guide](https://docs.aws.amazon.com/network-firewall/latest/developerguide/what-is-aws-network-firewall.html)
  - [AWS Transit Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)
  - [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

### C. Terraform AWS Provider & Registry
- **Terraform MCP Server (`terraform`)**:
  - Use `providerDetails`, `moduleDetails`, and available registry tools to verify provider version requirements, argument names, schema types, and deprecated attributes.
- **Web Documentation**:
  - [Terraform AWS Provider Registry Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
  - [Terraform Language Documentation](https://developer.hashicorp.com/terraform/docs)

### D. GitHub Actions Official Documentation *(Authoritative Source for Deployments)*
- **Web Documentation**:
  - [GitHub Actions Documentation](https://docs.github.com/en/actions) *(Authoritative source of truth for GitHub Actions CI/CD workflows, pipeline syntax, runner configurations, deployment environments, OIDC authentication, and automation)*

---

## 3. MCP Server & Resource Usage Protocol

When assisting with infrastructure tasks:

1. **Align with Databricks Hub-and-Spoke Pattern**:
   - Check routing rules, subnet divisions (public, firewall, TGW attachment, spoke private data/control plane subnets), and firewall domain allowlists against the [Databricks AWS E2 Firewall Guide](https://github.com/databricks/terraform-provider-databricks/blob/main/docs/guides/aws-e2-firewall-hub-and-spoke.md).
2. **Verify Resource Syntax**:
   - Query the **Terraform MCP Server** or official registry documentation to confirm the exact arguments, required blocks, and valid attribute values for `hashicorp/aws` and `databricks/databricks` resources.
3. **Use Databricks Documentation Skill for Gap Coverage**:
   - If requirements are unclear after checking the referenced architecture docs, use `databricks-docs` skill guidance to fetch `https://docs.databricks.com/llms.txt`, then follow the linked page that matches the exact feature.
4. **Follow Databricks AWS Workspace Provisioning Routing (`databricks-aws-workspace`)**:
   - When designing, creating, configuring, or modifying Databricks workspaces on AWS, strictly consult and follow the [`.github/skills/databricks-aws-workspace/SKILL.md`](./skills/databricks-aws-workspace/SKILL.md) skill.
   - Enforce the 3-tier API lifecycle (AWS Cloud -> Databricks Account MWS -> Databricks Workspace).
   - Ensure complete decoupling between account-level workspace creation (`provider = databricks.mws`) and workspace-level resource orchestration (`provider = databricks`) across separate modules.
   - Prevent credential validation race conditions (`MALFORMED_REQUEST: Failed credentials validation checks`) by injecting `time_sleep` dependencies between IAM policy attachment and workspace deployment.
5. **Validate AWS Service Constraints & IAM Policies**:
   - Query the **AWS Documentation MCP Server (`aws-docs`)** to verify security best practices (e.g., KMS key policies, bucket policies, VPC endpoint routing, IAM cross-account roles).
6. **Check for Deprecations**:
   - Verify that new resource blocks follow modern AWS provider syntax (e.g., standalone `aws_s3_bucket_*`, `aws_route_table`, `aws_networkfirewall_*` resources).

---

## 4. Documentation Standards & Authoritative README Template

### A. Mandatory README Template Usage
All `README.md` files produced across the repository—both for environments (`environments/<env>/README.md`) and reusable modules (`modules/<category>/<module_name>/README.md`)—**must strictly adhere** to the authoritative template:
- **Template Path**: [`.ai/README_TEMPLATE.md`](file:///.ai/README_TEMPLATE.md)

### B. Required README Structure
Every `README.md` must include the following standard sections:
1. **Executive Summary**: High-level purpose, problem solved, scope, and key business/security outcomes.
2. **General Logic of the Module / Environment**: Operational lifecycle, input calculation flow, and end-to-end traffic flow (egress, control plane, east-west).
3. **Architecture of the Module / Environment**: Subnet allocation, CIDR breakdown, routing matrix, KMS encryption, and security groups.
4. **Architecture C4 Visualisation**: Multi-tier Mermaid diagrams (System Context, Container/Network Infrastructure, and Component/Terraform orchestration).
5. **All Modules Used with Short Summaries**: Comprehensive inventory table and deep-dive descriptions for all submodules invoked.
6. **Terraform Documentation Interface**: Explicit reference to the auto-generated [`TERRAFORM.md`](./TERRAFORM.md) (maintained by `terraform-docs` via pre-commit hooks) alongside key highlighted inputs and outputs.
7. **Important Links and Resources**: Verified, active external links to official Databricks and AWS documentation, plus internal references.

### C. Documentation & Link Validation
- **Mandatory Link Verification**: Whenever any hyperlink (URL) is added to markdown (`.md`) files, it **must** be validated prior to committing to ensure it is active, reachable, and returns a valid HTTP response (HTTP 200, no dead or 404 links).
- **No Validation Boilerplate in READMEs**: Do NOT include verification notices, disclaimers, or boilerplate validation sentences (e.g., "Link Validation: All hyperlinks below have been checked and verified to return HTTP 200 responses" or "Link Integrity Requirement: ...") inside generated `README.md` files. Link validation is an internal quality and engineering standard for authors and CI/CD pipelines, not consumer-facing documentation content.

### D. Mermaid Syntax, CLI Installation & Validation Guide

All Mermaid diagrams generated for architecture visualizations (C4 System Context, Container/Network Infrastructure, Component/Terraform orchestration) **must be parsed and validated** before committing to eliminate syntax and rendering errors.

#### 1. Mermaid CLI (`mmdc`) Installation Instructions
Mermaid CLI (`@mermaid-js/mermaid-cli`) parses markdown files, extracts fenced `mermaid` code blocks, and validates or compiles them via headless Chromium (Puppeteer).

- **Prerequisites**:
  - [Node.js](https://nodejs.org/) (`>= 18.0.0` or current LTS) and `npm` installed and accessible in `PATH`.
  - Verify environment:
    ```bash
    node --version
    npm --version
    ```

- **Installation Methods**:
  - **Option 1: Global CLI Installation** (Recommended for local developer workstations):
    ```bash
    npm install -g @mermaid-js/mermaid-cli

    # Verify installation
    mmdc --version
    ```
  - **Option 2: On-Demand Execution via `npx`** (Zero-installation, ideal for CI/CD pipelines and automated agent workflows):
    ```bash
    # Runs the latest mermaid-cli directly without prior installation
    npx -y @mermaid-js/mermaid-cli --version
    ```
  - **Option 3: Project-Level Dependency**:
    ```bash
    npm install --save-dev @mermaid-js/mermaid-cli
    ```

- **Linux / CI Headless Configuration**:
  In headless Linux containers (e.g., GitHub Actions, Docker) where Chromium sandbox restrictions apply, supply a `puppeteer-config.json`:
  ```json
  {
    "args": ["--no-sandbox", "--disable-setuid-sandbox"]
  }
  ```
  Pass the configuration flag to `mmdc`:
  ```bash
  mmdc -p puppeteer-config.json -i input.md -o output.md
  ```

#### 2. Reusable Usage Instructions (Validation & Rendering)

- **Single Markdown File Validation**:
  Parse and validate all embedded Mermaid diagrams in a markdown file without altering the source file. If syntax errors exist, the command returns a non-zero exit code and outputs the line and error details:
  ```bash
  # Linux / macOS (Bash):
  npx -y @mermaid-js/mermaid-cli -i path/to/README.md -o /tmp/validate_out.md

  # Windows (PowerShell):
  npx -y @mermaid-js/mermaid-cli -i path\to\README.md -o "$env:TEMP\validate_out.md"
  ```

- **Standalone Diagram File Compilation (SVG / PNG)**:
  Compile an individual `.mmd` definition file into vector graphics or high-resolution bitmaps:
  ```bash
  # Render SVG vector diagram
  npx -y @mermaid-js/mermaid-cli -i architecture.mmd -o architecture.svg

  # Render high-resolution PNG (scaled 2x, 2048px width)
  npx -y @mermaid-js/mermaid-cli -i architecture.mmd -o architecture.png -w 2048 -s 2
  ```

- **Batch Repository-Wide Validation (Reusable Node.js Script)**:
  Use the following reusable script to scan and validate all markdown documentation across the repository:
  ```javascript
  // validate_mermaid.mjs
  import { execSync } from 'child_process';
  import fs from 'fs';
  import path from 'path';

  const filesToValidate = [
    'README.md',
    '.ai/README.md',
    '.ai/README_TEMPLATE.md',
    'environments/dev/README.md',
    'modules/01.networking/001.generic_vpc/README.md',
    'modules/01.networking/002.spoke_vpc/README.md',
    'modules/01.networking/003.hub_vpc/README.md',
    'modules/01.networking/004.transit_gateway_spoke_hub/README.md',
    'modules/01.networking/005.hub_networking_firewall/README.md',
    'modules/02.security/001.kms_key/README.md',
    'modules/03.storage/001.env_backend_bucket/README.md'
  ];

  const tempOut = path.resolve('temp_mermaid_validation.md');
  let failures = 0;

  for (const file of filesToValidate) {
    if (!fs.existsSync(file)) continue;
    process.stdout.write(`Validating: ${file} ... `);
    try {
      execSync(`npx -y @mermaid-js/mermaid-cli -i "${path.resolve(file)}" -o "${tempOut}"`, {
        stdio: 'pipe'
      });
      console.log('✅ PASS');
    } catch (err) {
      console.log('❌ FAIL');
      const output = (err.stderr?.toString() || '') + (err.stdout?.toString() || '');
      console.error(output);
      failures++;
    }
  }

  if (fs.existsSync(tempOut)) {
    fs.unlinkSync(tempOut);
  }

  if (failures > 0) {
    console.error(`\nValidation failed on ${failures} file(s).`);
    process.exit(1);
  } else {
    console.log('\nAll Mermaid diagrams validated successfully.');
  }
  ```
  Execute the runner:
  ```bash
  node validate_mermaid.mjs
  ```

#### 3. Core Mermaid Syntax Rules (Strictly Enforced)
1. **Subgraph Classing & Styling**:
   - **Prohibited**: `subgraph Id["Title"]:::className` (causes parser error `Expecting 'SEMI', 'NEWLINE', 'EOF', got 'STYLE_SEPARATOR'`).
   - **Mandatory**: Declare `subgraph Id ["Title"]` ... `end`, and assign the class on a dedicated line following the block:
     ```mermaid
     flowchart TD
         subgraph HubVPC ["Hub VPC"]
             NAT["NAT Gateway"]
         end
         class HubVPC hubVpcStyle;
     ```
2. **Node Label Quoting**:
   - Always enclose node labels in explicit double quotes: `nodeId["Service Name (VPC / Subnet)"]`.
   - Never leave unquoted parentheses, colons, brackets, or slashes inside labels.
3. **Prohibition of Raw HTML**:
   - Avoid raw HTML tags such as `<br/>`, `<b>`, or `<span>` inside node labels; use multiple spaced lines or distinct sub-nodes instead.
4. **Valid Connector Syntax**:
  - Standard solid arrow: `A --> B`
  - Labeled solid arrow: `A -->|"Encrypted TLS (443)"| B`
  - Labeled dotted reference: `A -.->|"KMS Key ARN"| B`

---

## 5. Project Standards & Best Practices

- **Security First**:
  - Enforce server-side encryption with customer-managed KMS keys where applicable.
  - Enforce least privilege in IAM and KMS key policies.
  - Block public access on all S3 buckets by default unless explicitly intended.
- **Networking Integrity**:
  - Maintain strict separation of concerns between Hub VPC (Transit Gateway, Network Firewall, NAT Gateways, Internet Gateway) and Spoke VPCs (Databricks Workspace compute and storage subnets).
  - Ensure all Databricks control plane and storage traffic routes through the firewall or VPC endpoints as dictated by the architecture guide.
- **State Management**:
  - Terraform remote state is stored in versioned, KMS-encrypted S3 buckets with DynamoDB state locking (`LockID` attribute).
- **CI/CD & GitHub Actions Deployments**:
  - Ground all workflow configurations, action plugins, OIDC authentication, and deployment automation in the official [GitHub Actions Documentation](https://docs.github.com/en/actions).
  - Retain all original pipeline jobs and steps (Pre-commit checks, Terraform Validate & Plan with plan caching, and Terraform Apply gated by Environment protection rules).
- **Code Organization**:
  - Follow modular architecture in `modules/` with isolated environments in `environments/<env>/` .
  - Maintain consistent file structure (`main.tf`, `variables.tf`, `locals.tf`, `outputs.tf`, `README.md`, `TERRAFORM.md`).
- **Formatting & Validation**:
  - Run `terraform fmt -recursive` and validate against configured linters (TFLint, Trivy, Checkov).

---

## 6. Repository Scaffolding, Module Architecture & Operational Guardrails

### A. Mandatory Base Repository Template (Absolute Requirement)
> [!IMPORTANT]
> **Base Template Requirement**: Whenever building a new repository for Databricks / AWS infrastructure, using this repository as the base template is an **absolute requirement**:
> - **Template Repository URL**: [https://github.com/MikolajSedek/databricks_aws_deployment_01_vpc_networking](https://github.com/MikolajSedek/databricks_aws_deployment_01_vpc_networking)
> - **Replication Scope**: Replicate the foundational repository structure, CI/CD GitHub Actions pipelines, pre-commit hook suites (`pre-commit`), security/linter configurations ([`.tflint.hcl`](file:///.tflint.hcl), [`.trivyignore`](file:///.trivyignore)), documentation templates ([`.ai/README_TEMPLATE.md`](file:///.ai/README_TEMPLATE.md)), and governance instructions ([`.ai/instructions.md`](file:///.ai/instructions.md)).

### B. Module Categorization & Functional Hierarchy
- **Functional Grouping (Not Technology)**:
  - Add new folders under `modules/` based strictly on **business and infrastructure functionality**, **never by raw technology or resource type**.
  - **Correct (Functional)**: `modules/01.networking/`, `modules/02.security/`, `modules/03.storage/`.
  - **Incorrect (Technological)**: `modules/ec2/`, `modules/s3/`, `modules/iam/`, `modules/databricks/`.
- **Subfolder Structure & Numbering**:
  - Place all new modules within `modules/{category_number.functionality}/{module_number.module_name}/` using zero-padded sequential prefixes.
  - Examples:
    - `modules/01.networking/001.generic_vpc/`
    - `modules/01.networking/002.spoke_vpc/`
    - `modules/02.security/001.kms_key/`
    - `modules/03.storage/001.env_backend_bucket/`
- **DRY vs. Pragmatism**:
  - Keep HCL code **DRY** (Don't Repeat Yourself) through reusable variables, locals, and submodules.
  - **Avoid over-engineering**: Do not introduce unnecessary layers of indirection, excessive meta-arguments, or rigid abstractions that obscure readability and maintenance.

### C. Module File Structure & Sizing Rules
When creating any new module, strictly follow this standard file layout:
- **`variables.tf`** (*Required*): All input variable definitions with explicit `type`, `description`, and appropriate `validation` blocks.
- **`main.tf`** (*Required*): Core primary resource declarations.
- **`locals.tf`** (*Optional*): Internal computations, mapped tags, and transformed data structures.
- **`outputs.tf`** (*Optional*): Return values and attributes exported for consumption by other modules or environments.
- **Extra Functional Files**:
  - Break resources into additional dedicated files named by functionality to keep `main.tf` modular and compact (e.g., `vpc_spoke_endpoints.tf`, `vpc_spoke_route_tables.tf`, `vpc_spoke_security_groups.tf`, `network_firewall_rule_groups.tf`).
- **File Length Limit**:
  - Keep `main.tf` compact: **avoid any `main.tf` exceeding 250 lines**.

### D. Authoritative Verification & Anti-Hallucination Policy
- **Authoritative Source Verification**:
  - Always use official, authoritative AWS and Databricks documentation and repositories (including [Official Databricks GitHub Repositories](https://github.com/orgs/databricks/repositories?type=all) and [Databricks Terraform Provider Examples](https://github.com/databricks/terraform-databricks-examples) — when deploying with AWS, use only AWS examples) when creating new Terraform code for any repository.
  - Verify every resource, block type, argument name, and behavior against official documentation or live MCP tools (`aws-docs`, `terraform`).
  - **Strict Anti-Hallucination**: Do not guess or invent resource arguments, attributes, or default values.
- **Databricks Provider Scopes (Account-Level vs. Workspace-Level)**:
  - Be explicitly aware that Databricks resources require different provider scopes:
    - **Workspace-Level Provider** (`host = https://<workspace-instance>.cloud.databricks.com/`): Used for clusters, jobs, notebooks, repos, workspace-level permissions, and workspace directory objects.
    - **Account-Level Provider** (`host = "https://accounts.cloud.databricks.com"`, `account_id = var.databricks_account_id`): Required for account-level provisioning including MWS networks (`databricks_mws_networks`), storage configurations (`databricks_mws_storage_configurations`), credentials (`databricks_mws_credentials`), workspaces (`databricks_mws_workspaces`), and account metastore assignments.
  - **Databricks AWS Workspace Provisioning Routing**:
    - For all workspace provisioning patterns, refer to the [`.github/skills/databricks-aws-workspace/SKILL.md`](./skills/databricks-aws-workspace/SKILL.md) skill. Follow the strict separation rule between the workspace creation module (`provider = databricks.mws`) and downstream workspace management modules (`provider = databricks`).
  - **Never guess provider scopes**: Always check the official [Databricks Terraform Provider Documentation](https://registry.terraform.io/providers/databricks/databricks/latest/docs) to determine whether a resource operates at the account or workspace level.

### E. Pre-Commit Execution, Documentation & Exception Handling
- **Pre-Commit Execution**:
  - Always execute pre-commit checks (`pre-commit run --all-files`) against newly created or modified code to validate formatting, linting, and security compliance.
- **Module README Generation**:
  - Provide a comprehensive `README.md` for each module adhering to the authoritative template ([`.ai/README_TEMPLATE.md`](file:///.ai/README_TEMPLATE.md)).
  - Ensure the corresponding `TERRAFORM.md` is generated and up-to-date (via `terraform-docs`).
- **Clear Documentation of Security Exceptions**:
  - If a security or linting exception is required (e.g., in [`.trivyignore`](file:///.trivyignore), [`.tflint.hcl`](file:///.tflint.hcl), or checkov skip comments), **always document it clearly and comprehensively**.
  - Document the Rule ID, Description, Target Resource, and detailed Justification covering:
    1. Functional requirement.
    2. Cloud provider / tooling limitation.
    3. Compensating security control (see [`.trivyignore`](file:///.trivyignore) for reference format).

### F. Verification & Operational Guardrails
- **Terraform Verification / Validation**:
  - At the end of implementation, always run `terraform validate` (`terraform verify`) across all modified modules and environments to ensure structural and syntactic validity.
- **Strict Apply Guardrail**:
  > [!CAUTION]
  > **NEVER run `terraform apply` without clear, explicit user consent.**
