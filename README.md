# Ubuntu base image

Based ont the standard ubuntu image but with some settings and tools I "always" want.

add the following to the docker run command to run the container as the current user:

```shell
 -e PGID=`id -g` -e PUID=`id -u`
```
