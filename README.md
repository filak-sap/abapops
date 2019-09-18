# abapops

ABAP Operation Tools

## Tools

- [abapmerge](https://github.com/larshp/abapmerge/)
- [sapcli](https://github.com/jfilak/sapcli/)

## Usage

```bash
docker pull filaksap/abapops

cd /var/tmp
git clone https://github.com/larshp/abapGit
cd abapGit

DOCKER_RUN="docker run -i --rm -v $(pwd):/repo --workdir /repo"

${DOCKER_RUN} filaksap/abapops abapmerge -f src/zabapgit.prog.abap > zabapgit_full.prog.abap

SAPCLI_ENV="-e SAP_HOST=172.17.0.2 -e SAP_CLIENT=001 -e SAP_SID=NPL -e SAP_PORT=8000 -e SAP_SSL=no -e SAP_USER=DEVELOPER -e SAP_PASSWORD=****"

${DOCKER_RUN} ${SAPCLI_ENV} filaksap/abapops sapcli package create '$abapgit' 'Git client by Lars Hvam'
${DOCKER_RUN} ${SAPCLI_ENV} filaksap/abapops sapcli program create zabapgit 'compiled abapgit' '$abapgit'
${DOCKER_RUN} ${SAPCLI_ENV} filaksap/abapops sapcli program write -a - zabapgit_full.prog.abap
```
