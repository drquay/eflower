<p align="center">
  <a href="https://github.com/ng-matero">
    <img width="150" src="https://avatars1.githubusercontent.com/u/49753463?s=200&v=4">
  </a>
</p>

<h1 align="center">
NG-MATERO
</h1>

<div align="center">

Ng-Matero is an Angular admin template made with Material components.

[![npm](https://img.shields.io/npm/v/ng-matero.svg)](https://www.npmjs.com/package/ng-matero)
[![GitHub Release Date](https://img.shields.io/github/release-date/ng-matero/ng-matero)](https://github.com/ng-matero/ng-matero/releases)
[![prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://prettier.io/)
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/ng-matero/ng-matero/blob/master/LICENSE)
[![Gitter](https://img.shields.io/gitter/room/ng-matero/ng-matero.svg)](https://gitter.im/matero-io/ng-matero)
[![docs](https://img.shields.io/badge/docs-gitbook-red)](https://nzbin.gitbook.io/ng-matero/)
[![Material Extensions](https://img.shields.io/badge/material-extensions-blue)](https://github.com/ng-matero/extensions#readme)
[![Financial Contributors on Open Collective](https://opencollective.com/ng-matero/all/badge.svg?label=financial+contributors)](https://opencollective.com/ng-matero)

</div>

## ✨ Features

- Material Extensions
- Schematics support
- Modern design style
- Multiple admin layout
- Powerful color system
- Rich CSS helpers
- Dark mode support
- RTL support
- Internationalization
- Authentication
- HTTP interceptors
- Permissions management

## 📖 Documentation

[English](https://nzbin.gitbook.io/ng-matero/v/en/) ｜[简体中文](https://nzbin.gitbook.io/ng-matero/)

## 📦 Compatibility

Which version to use?

| Angular | Material | Ng-Matero | Extensions |
| ------- | -------- | --------- | ---------- |
| v13     | v13      | 13.x.x    | 13.x.x     |
| v12     | v12      | 12.7.4    | 12.7.0     |
| v11     | v11      | 11.3.2    | 11.5.1     |
| v10     | v10      | 10.4.1    | 10.16.5    |
| v9      | v9       | 9.7.2     | 9.11.14    |
| v8      | v8       | 0.16.0    | 0.9.3      |

## 🔧 Installation

The project has support `ng add` yet.

```bash
$ ng new <project-name>
$ cd <project-name>
$ ng add ng-matero
```

You can also git clone the starter repo to start. But it's not recommended.

```bash
$ git clone --depth=1 git@github.com:ng-matero/starter.git <project-name>
$ cd <project-name>
$ npm install
```

## ⚙️ Schematics

You can use the ng-matero schematics to generate a module or a page.

### Module schematic

Generate a lazy loaded module.

```bash
$ ng g ng-matero:module <module-name>
```

The new module will be created in `routes` folder, it will be added in `routes.module` and its route declaration will be added in `routes-routing.module` automaticly.

### Page schematic

Generate a page component in the module.

```bash
$ ng g ng-matero:page <page-name> -m=<module-name>
```

Generate a entry component in the page component.

```bash
$ ng g ng-matero:page <page-name>/<entry-component-name> -m=<module-name> -e=true
```

### Example

Just two steps after initializing the project, you can get a route page.

```bash
$ ng g ng-matero:module abc
$ ng g ng-matero:page def -m=abc
```

Take a look at `http://localhost:4200/#/abc/def`, enjoy it!

## 💻 Development

```bash
$ git clone git@github.com:ng-matero/ng-matero.git
$ cd ng-matero
$ npm install
$ npm run hmr
```

Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## 🗺 Roadmap

Check [projects](https://github.com/ng-matero/ng-matero/projects) to know the develop plans.

## 🤝 Contributors

### Code Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<a href="https://github.com/ng-matero/ng-matero/graphs/contributors"><img src="https://opencollective.com/ng-matero/contributors.svg?width=890&button=false" /></a>

### Financial Contributors

Become a financial contributor and help us sustain our community. [[Contribute](https://opencollective.com/ng-matero/contribute)]

#### Individuals

<a href="https://opencollective.com/ng-matero"><img src="https://opencollective.com/ng-matero/individuals.svg?width=890"></a>

#### Organizations

Support this project with your organization. Your logo will show up here with a link to your website. [[Contribute](https://opencollective.com/ng-matero/contribute)]

<a href="https://opencollective.com/ng-matero/organization/0/website"><img src="https://opencollective.com/ng-matero/organization/0/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/1/website"><img src="https://opencollective.com/ng-matero/organization/1/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/2/website"><img src="https://opencollective.com/ng-matero/organization/2/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/3/website"><img src="https://opencollective.com/ng-matero/organization/3/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/4/website"><img src="https://opencollective.com/ng-matero/organization/4/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/5/website"><img src="https://opencollective.com/ng-matero/organization/5/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/6/website"><img src="https://opencollective.com/ng-matero/organization/6/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/7/website"><img src="https://opencollective.com/ng-matero/organization/7/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/8/website"><img src="https://opencollective.com/ng-matero/organization/8/avatar.svg"></a>
<a href="https://opencollective.com/ng-matero/organization/9/website"><img src="https://opencollective.com/ng-matero/organization/9/avatar.svg"></a>

## 📃 License

MIT

## Code

token: save in the Cookie with HtppOnly and SSL.
user info: save in the Storage.
isAuthenticated: save in the Store.

[Generate certification]
openssl genrsa -out key.pem 2048
openssl req -new -sha256 -key key.pem -out eflower.csr
openssl req -x509 -sha256 -key key.pem -in eflower.csr -out cert.pem
openssl pkcs12 -export -out eflower.p12 -inkey key.pem -in cert.pem

[Ec2]
gcloud compute ssh --zone "asia-southeast1-b" "instance-1"  --project "big-booking-350408"
acc: vnthanh25/Ab.14

[Deploy angular]
Copy 'dist' folder to 'deploy'
Open cmd
cd dist
npm install http-server -g
http-server -S -C cert.pem

[Deploy ec2]
https://dev.to/marwan01/deploy-an-angular-app-using-google-cloud-run-3p4a

1- Create dockerfile
2- Create server.js
3- Run command:
docker build -t app-tag .
docker run -p 8080:8080 app-tag
4- Deploy App:
gcloud builds submit --tag gcr.io/PROJECT-ID/eflower
gcloud run deploy --image gcr.io/PROJECT-ID/eflower --platform managed

[Install nodejs]
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node

[Install unzip]
sudo apt-get install zip unzip

[Install angular]
npm install -g @angular/cli
npm install angular-http-server -g

[Copy file]
scp /Users/macintoshhd/Documents/VNT/Project/eflower/eflower-frontend/dist/eflower.zip root@172.105.115.163:/root/eflower.zip

ssh root@172.105.115.163
pass

unzip eflower.zip

[Run]
cd eflower
nohup angular-http-server . -p 4200 &
enter
exit
exit
close browser

[Run]
node server.js
[Run backgrou proccess]
nohup node server.js &
enter
exit
exit
close browser


[Stop]
ps aux | grep 4200
kill -9 [id]

rm -r eflower
rm -f eflower.zip
