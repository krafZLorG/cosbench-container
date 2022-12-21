# How to use this image

### Start local driver and controller

```
podman run -d --net host --name cosbench localhost/cosbench
```

### Start driver

```
podman run -d --net host --name cosbench-driver localhost/cosbench driver
```

### Start controller

Prepare controller.conf
```
[controller]
drivers = 1
log_level = WARN
log_file = log/system.log
archive_dir = archive

[driver1]
name = driver1
url = http://127.0.0.1:18088/driver
```

```
podman run -d --net host --name cosbench-controller \
  -v ./archive:/cosbench/archive \
  -v ./log:/cosbench/log \
  -v ./controller.conf:/cosbench/conf/controller.conf:ro \
localhost/cosbench controller
```


## How to build container

#### Download and copy to rpms:

```
libbsd-*.el8.x86_64.rpm
libretls-*.el8.x86_64.rpm
libmd-*.el8.x86_64.rpm
netcat-*.el8.x86_64.rpm
which-*.el8.x86_64.rpm
```

For example:

```
wget -P rpms https://mirror.yandex.ru/epel/8/Everything/x86_64/Packages/l/libbsd-0.11.7-2.el8.x86_64.rpm
wget -P rpms https://mirror.yandex.ru/epel/8/Everything/x86_64/Packages/l/libretls-3.5.2-1.el8.x86_64.rpm
wget -P rpms https://mirror.yandex.ru/epel/8/Everything/x86_64/Packages/l/libmd-1.0.4-2.el8.x86_64.rpm
wget -P rpms https://mirror.yandex.ru/epel/8/Everything/x86_64/Packages/n/netcat-1.219-1.el8.x86_64.rpm
wget -P rpms https://mirror.yandex.ru/centos/8-stream/BaseOS/x86_64/os/Packages/which-2.21-18.el8.x86_64.rpm
```

#### Download and unzip consbench 0.4.2.c4

```
wget https://github.com/intel-cloud/cosbench/releases/download/v0.4.2.c4/0.4.2.c4.zip
unzip 0.4.2.c4.zip
```

#### Modify `0.4.2.c4/cosbench-start.sh`

We now need to pass a parameter "-N" to terminate netcat, because nc no longer terminates on its own, after cosbench finishes sending its active data.

```
TOOL_PARAMS="-N"
```

and modify line 46

```
46c46
< /usr/bin/nohup java -Dcosbench.tomcat.config=$TOMCAT_CONFIG -server -cp main/* org.eclipse.equinox.launcher.Main -configuration $OSGI_CONFIG -console $OSGI_CONSOLE_PORT 1> $BOOT_LOG 2>&1 &
---
> /usr/bin/nohup java -Dcom.amazonaws.services.s3.disableGetObjectMD5Validation=true -Dcosbench.tomcat.config=$TOMCAT_CONFIG -server -cp main/* org.eclipse.equinox.launcher.Main -configuration $OSGI_CONFIG -console $OSGI_CONSOLE_PORT 1> $BOOT_LOG 2>&1 &
```

#### Add log_level to 0.4.2.c4/conf/driver_template.conf

```
log_level=WARN
```

#### Build

```
podman pull registry.access.redhat.com/ubi8/openjdk-8-runtime:1.14-6.1666624659
podman build -t cosbench .
```
