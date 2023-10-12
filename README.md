# Flaskr
======

The basic blog app built in the Flask `tutorial`

tutorial: https://flask.palletsprojects.com/tutorial/


[_Acornfile_](.Acornfile)
```
containers: {
  web: {
    build: {
      context: "."
      target: "builder"
    }
   env: {
      if args.dev { 
        "FLASK_DEBUG": "1"
      }
    }
    if args.dev { dirs: "/app": "./" }
    ports: publish: "5000/http"
  }
}
```

## Deploy with Acorn

Make sure to [_Install Acorn_]: <https://docs.acorn.io/installation/installing> before running acorns. 

Clone this repo to get started and run below command to deploy this project

```bash
  acorn run
```

## Explaining the Acornfile


* `containers` section: describes the set of containers your Acorn app consists of

  * Note: app, db and cache are custom names of your containers
  * `app` - Our Python Flask App
    * `build`: build from Dockerfile that we created
    * `env`: environment variables, statically defined, referencing a secret or referencing an Acorn argument
    * `ports`: using the publish type, we expose the app inside the cluster but also outside of it using an auto-generated ingress resource
    * `dirs`: Directories to mount into the container filesystem
      * `dirs: "/app": "./"`: Mount the current directory to the /app dir, which is where the code resides inside the container as per the Dockerfile. This is to enable hot-reloading of code.


## Run your Application

To start your Acorn app just run:

```bash
acorn run -n flask-app . 
```
The `-n flask-app` gives this app a specific name so that the rest of the steps can refer to it. If you omit `-n`, a random two-word name will be generated.

## Access your app

Due to the configuration `ports: publish: "8000/http"` under `containers.app`, our web app will be exposed outside of our Kubernetes cluster using the cluster's ingress controller. Checkout the running apps via

```bash
acorn apps
```

```bash
$ acorn apps
NAME        IMAGE          COMMIT         CREATED     ENDPOINTS                                          MESSAGE
flask-app   0ed9a2b95c69   114c50666ed9   3m22s ago   http://web-flask-app-98d916c5.local.oss-acorn.io   OK

```

## Development Mode

In development mode, Acorn will watch the local directory for changes and synchronize them to the running Acorn app. In general, changes to the Acornfile are directly synchronized, e.g. adding environment variables, etc. Depending on the change, the deployed containers will be recreated.

```bash
acorn dev -n flask-app
```

The lines `if args.dev { dirs: "/app": "./" }` enable hot-reloading of code by mounting the current local directory into the app container.

You will see the change applied when you reload the application's page in your browser.




