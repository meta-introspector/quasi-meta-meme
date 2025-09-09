# setup workflow : 300 SOLFUNMEME

**ID:** 950840
**Created At:** 2025-01-19T22:50:32+00:00
**Source:** https://codeberg.org/introspector/SOLFUNMEME/issues/34

---

TAKS : 
Read this doc, fork the repo 
https://codeberg.org/introspector/SOLFUNMEME/
 and enable actions and demonstrate they work

Input  https://forgejo.org/docs/latest/admin/actions/
Forgejo Actions administrator guide
Forgejo Actions provides continuous integration driven from the files found in the .forgejo/workflows directory of a repository. Note that Forgejo does not run the jobs, it relies on the Forgejo runner to do so. It needs to be installed separately.

Settings
Default Actions URL
In a workflow, when uses: does not specify an absolute URL, the value of DEFAULT_ACTIONS_URL is prepended to it.

[actions]
ENABLED = true
DEFAULT_ACTIONS_URL = https://data.forgejo.org
The actions published at https://data.forgejo.org are:

known to work with Forgejo Actions
published under a Free Software license
They can be found in organizations such as actions for general purpose actions, docker for those related to Docker and so on.

When setting DEFAULT_ACTIONS_URL to a Forgejo instance with an open registration, care must be taken to avoid name conflicts. For instance if an action has uses: foo/bar@main it will clone and try to run the action found at DEFAULT_ACTIONS_URL/foo/bar if it exists, even if it provides something different than what is expected.

Disabling
As of Forgejo v1.21 it is enabled by default. It can be disabled by adding the following to app.ini:

[actions]
ENABLED = false
Storage
The logs and artifacts are stored in Forgejo. The cache is stored by the runner itself and never sent to Forgejo.

job logs
The logs of each job run is stored by the Forgejo server and never expires. The location where these files are stored is configured in the storage.actions_log section of app.ini as explained in in the storage documentation.

artifacts logs
The artifacts uploaded by a job are stored by the Forgejo server and expire after a delay that defaults to 90 days and can be configured as follows:

[actions]
ARTIFACT_RETENTION_DAYS = 90
The location where these artifacts are stored is configured in the storage.artifacts section of app.ini as explained in in the storage documentation.

The admin/monitor/cron administration web interface can be used to manually trigger the Cleanup actions expired logs and artifacts task instead of waiting for the scheduled task to happen.

Forgejo runner
The Forgejo runner is a daemon that fetches workflows to run from a Forgejo instance, executes them, sends back with the logs and ultimately reports its success or failure.

Installation and setup instructions can be found in the Forgejo Runner installation guide.

Choosing labels
Runner labels are used by workflows to define what type of environment they need to be executed in. Each runner declares a set of labels, and the Forgejo server will send it tasks accordingly. For example, a workflow with:

runs-on: docker
will be run on a runner which has declared a docker label.

A label has the following structure:

<label-name>:<label-type>://<default-image>
The label name is a unique string that identifies the label. It is the part that is specified in the runs-on field of workflows to choose which runners the workflow can be executed on.

The label type determines what containerization system will be used to run the workflow. There are three options:

Docker or Podman
If a label specifies docker as its label type, the rest of it is interpreted as the default container image to use if no other is specified. The runner will execute all the steps, as root, within a container created from that image.

The default container container image can be overridden by a workflow:

runs-on: docker
container:
  image: alpine:3.20
See the user documentation for jobs.<job_id>.container for more information.

Label examples:

node20:docker://node:20-bookworm == node20:docker://docker.io/node:20-bookworm defines node20 to be the node:20-bookworm image from hub.docker.com
docker:docker://data.forgejo.org/oci/alpine:3.20 defines docker to be the alpine:3.20 image from https://data.forgejo.org/oci/-/packages/container/alpine/3.20
LXC
If a label specifies lxc as its label type, the rest of it is interpreted as the default template and release to use if no other is specified. The runner will execute all the steps, as root, within a LXC container created from that template and release. The default template is debian and the default release is bullseye.

nodejs version 20 is installed.

The default template and release can be overridden by a workflow:

runs-on: lxc
container:
  image: debian:bookworm
See the user documentation for jobs.<job_id>.container for more information.

Label example:

bookworm:lxc://debian:bookworm defines bookworm to be an LXC container running Debian GNU/Linux bookworm.
Host
If a label specifies host as its label type, the runner will execute all the steps in a shell forked from the runner, directly on the host.

Warning: There is no isolation at all and a single job can permanently destroy the host.

Label example:

self-hosted:host://-self-hosted defines self-hosted to be a shell
Special labels
Runner labels can also be used to define other special features a runner has. For example, you could use gpu:docker://node:20-bullseye to define a runner that has a GPU installed. Workflows which need a GPU could then specify runs-on: gpu to be executed on this runner.

Mimicking GitHub runners
To mimic the GitHub runners, the runs-on field can be set to ubuntu-22.04:docker://node:20-bullseye for instance. With this, the Forgejo runner will respond to runs-on: ubuntu-22.04 and will use the node:20-bullseye image from hub.docker.com. This image is quite capable of running many of the workflows that are designed for the GitHub runners. For a slightly bigger image, use ghcr.io/catthehacker/ubuntu:act-22.04 instead of node:20-bullseye which should be compatible with most actions while remaining relatively small. There exist larger images used that can go up to 20GB compressed with more software installed if needed.

Other runners
It is possible to use other runners instead of Forgejo runner. As long as they can connect to a Forgejo instance using the same protocol, they will be given tasks to run.
