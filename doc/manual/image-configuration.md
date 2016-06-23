## Image configuration

The plugin's configuration is centered around *images*. These are
specified for each image within the `<images>` element of the
configuration with one `<image>` element per image to use.

The `<image>` element can contain the following sub elements:

* **name** : Each `<image>` configuration has a mandatory, unique docker
  repository *name*. This can include registry and tag parts, but also placeholder
  parameters. See below for a detailed explanation.
* **alias** is a shortcut name for an image which can be used for
  identifying the image within this configuration. This is used when
  linking images together or for specifying it with the global
  **image** configuration.
* **registry** is a registry to use for this image. If the `name`
  already contains a registry this takes precedence. See
  [Registry handling](#registry-handling) for more details.
* **build** is a complex element which contains all the configuration
  aspects when doing a `docker:build` or `docker:push`. This element
  can be omitted if the image is only pulled from a registry e.g. as
  support for integration tests like database images.
* **run** contains subelements which describe how containers should be
  created and run when `docker:start` or `docker:stop` is called. If
  this image is only used a *data container* for exporting artifacts
  via volumes this section can be missing.
* **external** can be used to fetch the configuration through other
  means than the intrinsic configuration with `run` and `build`. It
  contains a `<type>` element specifying the handler for getting the
  configuration. See [External configuration](#external-configuration)
  for details.

When specifying the name you can use several placeholders which are replaced
during runtime by this plugin. In addition you can use regular Maven properties which are resolved by Maven itself.

* **%g** The last part of the Maven group name, sanitized so that it can be used as username on GitHub. Only the part after the last dot is used. E.g. for a group id `io.fabric8` this placeholder would insert `fabric8`.
* **%a** A sanitized version of the artefact id so that it can be used as part of an Docker image name. I.e. it is converted to all lower case (as required by Docker).
* **%v** The project version. Synonym to `${project.version}`.
* **%l** If the project version ends with `-SNAPSHOT` then this placeholder is `latest`, otherwise its the full version (same as `%v`).
* **%t** If the project version ends with `-SNAPSHOT` this placeholder resolves to `snapshot-<timestamp>` where timestamp has the date format `yyMMdd-HHmmss-SSSS` (eg `snapshot-`). This feature is especially useful during development in oder to avoid conflicts when images are to be updated which are still in use. You need to take care yourself of cleaning up old images afterwards, though.


Either a `<build>` or `<run>` section must be present. These are explained in
details in the corresponding goal sections.

Example:

````xml
<configuration>
  ....
  <images>
    <image>
      <name>%g/docker-demo:0.1</name>
      <alias>service</alias>
      <run>....</run>
      <build>....</build>
    </image>
  </images>
</configuration>
````
