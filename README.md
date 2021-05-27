# SiouxSilos Web server AMI

Generates an Amazon Machine Image (AMI) using [Hashicorp Packer](https://www.packer.io/).
The image is based on Ubuntu 18.04 LTS and comes with nginx preinstalled.

Future roadmap:
- [x] Install nginx with basic configuration
- [ ] Install dotnet 5 core runtime
- [ ] Use AWS CodeDeploy to deploy the artifact from [our core project](https://github.com/10kloud/core)
