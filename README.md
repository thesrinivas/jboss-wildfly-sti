# WildFly 8 STI enabled image

This repository contains `Docekrfile` for the WildFly image that makes integration with [STI](https://github.com/openshift/source-to-image) easy. STI is a project that takes care of build process of your application and the result is a new Docker image with your application ready to be run on the WildFly application server.

STI is part of [OpenShift](https://github.com/openshift/origin), but can be used standalone too.

## Building

`docker build -t jboss/wildfly-sti .`

## Scripts

The STI builder does require a few scripts, below you can find the location and purpose of them.

* `.sti/assemble`

    This script is responsible for executing the actual build. The build process itself is following:

        [restore artifacts] > [execute the build] > [prepare application for deployment]

    Restiring artifacts is an optional step. STI supports incremental builds. This means that a build executed first time could save some files used to build the image and then restore it in subsequent build. In case of Java applications built with Maven artifacts could be the `.jar` files and all the associated metadata downloaded from a Maven repository. The `jboss/wildfly-sti` image save the whole `.m2/` folder. This makes the build faster since we don't need to download all the artifacts again.
    
    After the build was finished the application (currently only `*.war` files) are moved to the WildFly `$JBOSS_HOME/standalone/deployments/` directory. Finally a new image will be created (using the `jboss/wildfly-sti` iamge as the base).
    
    Application will be run for the **first time when you lanch the new image**.
    
* `.sti/run`

    This script contains the command to be executed at the launch time of the container. The `run` script path will be added to the `Dockerfile` as  `CMD` instruction. This is still required, but will be removed once [#114](https://github.com/openshift/source-to-image/issues/114) will be fixed. In that case the `jboss/wildfly` default command will be reused.

* `.sti/save-artifacts`

    In order to do an *incremental build* this script is responsible for archiving files that will be reused in the next build. In this image, this script will archive the Maven dependencies (`.m2/` directory) and previously built Java class files (`target` directory).

## Environment variables

*  **STI_SCRIPTS_URL** (default: '[.sti/](https://raw.githubusercontent.com/goldmann/openshift-jboss-wildfly/master/.sti)')

  This variable specifies the location of directory, where *assemble*, *run* and *save-artifacts* scripts are downloaded/copied from. By default the scriptsin this repository will be used, but users can provide an alternative location and run their own scripts.
  
## Copyright

Released under the MIT license. See the [LICENSE](https://github.com/goldmann/openshift-jboss-wildfly/blob/master/LICENSE) file.
