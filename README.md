# [![devGaido][devgaido-image]][devgaido-url]

[Overview](#overview) | [Services](#services) | [License](#license)


## Overview

devGaido provides a guided learning experience through the Web Development 
ecosystem by providing those new to the craft with predefined paths to aid in
achieving web development skills. For experienced developers it provides a 
a means of filling in skill gaps around specific technologies, libraries, and
languages.

You can find devGaido at [www.devgaido.com](http://www.devgaido.com) and the  [devGaido application repo](https://github.com/Chingu-cohorts/devgaido).

## Services

DevOps services are defined as any function which externally supports the application. In other words, any support function that operates outside the main application, like database backups.

The devops services used to support the devGaido app include:

| DevOps Service  | Directory | Purpose                           |
|:----------------|:----------|:----------------------------------|
| App runtime     | runtime   | Application runtime configuration |
| Backup          | backup    | Backup scripts and configuration  |
| Documentation   | docs      | App and DevOps documentation      |

Issues should be reported on the main GitHub repo for the [devGaido App](https://github.com/Chingu-cohorts/devgaido) sto consolidate all issues in one location. Similarly, wiki entries should be created on the main repo for the same reason.

### Application Runtime

#### Built With

devGaido's runtime architecture leverages the following to achieve performance,
availability, and ease of deployment:

- CDN: A content delivery network (CDN) is used to reduce the amount of time 
necessary to serve up images and other static content.
- Nginx: Is a web server providing security (HTTPS), compression,
and load balancing.
- Docker: Docker containers house devGaido's application components that make
devGaido easier to deploy and manage.
- Bash: Bash scripts are used to automate devops operations such as backups, monitoring, and administrator alerting and notification.

### Backup & Recovery 

![devGaido Backup Architecture](https://github.com/Chingu-cohorts/devgaido_devops/blob/refactor/repo/docs/devGaido%20Backup%20Process.png?raw=true)

### Documentation

All documentation files and diagrams are stored in this repo so as not to pollute the main application repo. The purpose is to keep the generated application bundle size as small as possible.

## License

[MIT](https://tldrlegal.com/license/mit-license)

[devgaido-image]: https://cdn.rawgit.com/Chingu-cohorts/devgaido/development/src/client/assets/img/devGaidoLogo.svg
[devgaido-url]: https://github.com/Chingu-cohorts/devgaido

