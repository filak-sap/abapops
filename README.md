# abapops

ABAP Operation Tools available as the Docker image [filaksap/abapops](https://hub.docker.com/r/filaksap/abapops)

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

### RFC

To be able to use RFC features of *sapcli* you must provide
[SAP NetWeaver RFC SDK](https://support.sap.com/en/product/connectors/nwrfcsdk.html)
libraries.

These libraries are listed in the [PyRFC installation manual](https://sap.github.io/PyRFC/install.html#linux)
and can be found on file system of your ABAP server.

The container expects the libraries at **/usr/local/sap/nwrfcsdk/lib**.

Of course, it is much simpler to create your own docker image with
the libraries bundled instead of passing them via a volume.

```bash
docker pull filaksap/abapops

DOCKER_RUN="docker run -i --rm -v /path/to/the/nw_rfc_sdk_libs:/usr/local/sap/nwrfcsdk/lib"

SAPCLI_ENV="-e SAP_HOST=172.17.0.2 -e SAP_SYSNR=00 -e SAP_CLIENT=001 -e SAP_SID=NPL -e SAP_USER=DEVELOPER -e SAP_PASSWORD=****"

${DOCKER_RUN} ${SAPCLI_ENV} filaksap/abapops sapcli startrfc STFC_CONNECTION '{"REQUTEXT":"ping"}'
```
