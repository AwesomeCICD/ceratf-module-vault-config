## Add Namespace: <NEW_NS>

#### Project
<!-- Make sure you have already created at least a skeleton project. You must use that project ID in auth role claims -->
https://app.circleci.com/pipelines/github/AwesomeCICD/cera-apps-scara

#### Appspaces PR
<!-- This change should only be needed when adding new namesapves to the ceratf-module-appspaces repository.  Link corresponding PR here -->
AwesomeCICD/ceratf-module-appspaces#1

- [ ] I have added a policy that points to NS specific secrets
- [ ] I have created a backend role for auth that includes above policy(ies) 
  - [ ] I have the right project ID in the auth role
  - [ ] I have the right contexts in auth role OR have dropped context enforcement
- [ ] I need nexus (docker push) and included it
  - [ ] I do NOT need nexus
- [ ] i ran `terraform fmt`
