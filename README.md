DevOps Fundamentals<br>
EPAM<br>
#DevOps<br>
#IT SERVICES

[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)

<img
src="https://cdn.imgbin.com/11/20/3/imgbin-vagrant-hashicorp-virtual-machine-software-developer-installation-vagrant-ywTTwLKhjrGBxXiPdJNgpkc9D.jpg"
height=48 width=48 alt="Vagrant Logo" />

1. Установка Vagrant<br>
2. Установка VirtualBox + VirtualBox Extension Pack<br>
При утановке VirtualBox Host-Only Ethernet Adapter по-умолчанию добавляется VirtualBox Host-Only Ethernet Adapter. При написании Vagrantfile отталкиваюсь от того что он есть, потому его не учитываю в работе (у меня он переконфигурирован под тетовую сеть 10.50.10.0/24).

К Linux ВМ можно подключится, например так:
```
ssh appuser@192.168.1.2 -i ~/.ssh/appuser
```