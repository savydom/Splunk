# Splunk Enterprise

#### Adapted from [docker-splunk](https://github.com/splunk/docker-splunk) to fit the Air Force's requirements.

----

## Purpose

### What is Splunk Enterprise?
[Splunk Enterprise](https://www.splunk.com/en_us/software/splunk-enterprise.html) is a platform for operational intelligence. Our software lets you collect, analyze, and act upon the untapped value of big data that your technology infrastructure, security systems, and business applications generate. It gives you insights to drive operational performance and business results.

See [Splunk Products](https://www.splunk.com/en_us/software.html) for more information about the features and capabilities of Splunk products and how you can [bring them into your organization](https://www.splunk.com/en_us/enterprise-data-platform.html).

The provisioning of these containers is handled by the [Splunk-Ansible](https://github.com/splunk/splunk-ansible) project. Refer to the [Splunk-Ansible documentation](https://splunk.github.io/splunk-ansible/) and the [Ansible User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html) for more details.

To assist with running Splunk in a Kubernetes environment, there is the [Splink Operator for Kubernetes](https://github.com/splunk/splunk-operator) project. Please see the [Getting Started](https://github.com/splunk/splunk-operator/blob/master/docs/README.md) documentation for using the Splunk Operator.

---

## Quickstart

Start a single containerized instance of Splunk Enterprise with the command below, replacing `<password>` with a password string that conforms to the [Splunk Enterprise password requirements](https://docs.splunk.com/Documentation/Splunk/latest/Security/Configurepasswordsinspecfile).
```bash
$ docker run -p 8000:8000 -e "SPLUNK_PASSWORD=<password>" \
             -e "SPLUNK_START_ARGS=--accept-license" \
             -e "SPLUNK_HOME_OWNERSHIP_ENFORCEMENT=false" \
             -it --name so1 splunk:latest
```

This command does the following:
1. Starts a Docker container using the `splunk:latest` image.
1. Names the container as `so1`.
1. Exposes a port mapping from the host's `8000` port to the container's `8000` port
1. Specifies a custom `SPLUNK_PASSWORD`.
1. Accepts the license agreement with `SPLUNK_START_ARGS=--accept-license`. This agreement must be explicitly accepted on every container or Splunk Enterprise doesn't start.
1. Set the Splunk Home Ownership to false with `SPLUNK_HOME_OWNERSHIP_ENFORCEMENT=false` as we are required to start the container as the splunk user for security reasons.

After the container starts up, you can access Splunk Web at <http://localhost:8000> with `admin:<password>`.

To view the logs from the container created above, run:
```bash
$ docker logs -f so1
```

To enter the container and run Splunk CLI commands, run:
```bash
# Defaults to the user "ansible"
docker exec -it so1 /bin/bash

# Run shell as the user "splunk"
docker exec -u splunk -it so1 bash
```

To enable TCP 10514 for listening, run:
```bash
docker exec -u splunk so1 /opt/splunk/bin/splunk add tcp 10514 \
    -sourcetype syslog -resolvehost true \
    -auth "admin:${SPLUNK_PASSWORD}"
```

To install an app, run:
```bash
docker exec -u splunk so1 /opt/splunk/bin/splunk install \
	/path/to/app.tar -auth "admin:${SPLUNK_PASSWORD}"
```

---

## Documentation
Visit the [Docker-Splunk documentation](https://splunk.github.io/docker-splunk/) page for full usage instructions, including installation, examples, and advanced deployment scenarios.

Not all Documentation at this link will be applicable to this specific image as it has specific build dependencies for the Air Force.

### Python Support
Python 2 has been removed from the image based on it being end of life. Any Splunk apps or scripts that rely on Python 2 will not work and will need to be re-written for Python 3. Python 3 is included in the image.

### Data Fabric Search
With DFS being [end of support](https://docs.splunk.com/Documentation/DFS/1.1.2/DFS/Overview) in Oct of 2021, we have started to remove packages required for DFS to function. As such, DFS cannot function in this image of Splunk.
