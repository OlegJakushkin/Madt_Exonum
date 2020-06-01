# MADT_Exonum

1. Скачайте и запустите MADT:

```
cd ~
git clone --recursive https://github.com/dltcspbu/madt/
mkdir ~/madt/labs && export MADT_LABS_DIR=$HOME/madt/labs
mkdir ~/madt/sockets && export MADT_LABS_SOCKETS_DIR=$HOME/madt/sockets

cd madt
sudo pip3 install -r ./requirements.txt
sudo make && sudo make install

sudo -HE env PYTHONPATH=$HOME/madt:$PYTHONPATH SSH_PWD=demo python3 madt_ui/main.py 80
```

2. Перейдите в директорию `./tutorials`, склонируйте данный проект, соберите образ и запустите lab.py:

```
#open new terminal window
cd ~/madt/tutorials
git clone https://github.com/IvPod/Madt_Exonum.git
docker build -t madt/exonum .
python3 ./lab.py
```

![image](./images/image.jpg)

3. Перейдите на 127.0.0.1:80, для login используйте: `demo:demo`
4. После открытия лаборатории вы должны увидеть следующее: ![image](./images/dag.jpg)
5. Проверьте, что все контейнеры запущены:
   ![image](./images/nodes.jpg)
6. Запустите скрипт для тестирования:

```
cd ./tests
bash test.sh
```

7. Пример запуска и тестирования:
   ![Alt Text](./images/madt_exonum.gif)

- Запускаем MADT;

```
sudo -HE env PYTHONPATH=$HOME/madt:$PYTHONPATH SSH_PWD=demo python3 madt_ui/main.py 80
```

- Запускаем лабораторию с заранее собранным образом:

```
sudo python3 ./lab.py
```

- Проверяем статус нашей лаборатории используя MADT UI;
- Проверяем, что контейнеры работают;
- Проверяем работоспособность с помощью ./tests/test.sh:

```
1) Запускаем узлы;
2) Создаём два кошелька;
3) В первый кошелёк добавляем средства;
4) Переправляем средства с одного кошелька на второй;
5) Проверяем счёт первого кошелька;
6) Проверяем счёт второго кошелька.
```

8. Для запуска узлов используйте скрипт:

```
bash runNodes.sh

As result:
new node with ports: 8000 (public) and 8050 (private)
new node with ports: 8001 (public) and 8051 (private)
new node with ports: 8002 (public) and 8052 (private)
new node with ports: 8003 (public) and 8053 (private)
new node with ports: 8004 (public) and 8054 (private)
```

## Тестирование вне Madt

1. Создадим сеть:

```
docker network create PRIVATENET
```

2. Создадим 4 контейнера:

```
docker run -it --net=PRIVATENET -p 6331:6331 -p 8000:8000 -p 8008:8008 --name exonum_1 -d madt/exonum
docker run -it --net=PRIVATENET -p 6332:6332 -p 8001:8001 --name exonum_2 -d madt/exonum
docker run -it --net=PRIVATENET -p 6333:6333 -p 8002:8002 --name exonum_3 -d madt/exonum
docker run -it --net=PRIVATENET -p 6334:6334 -p 8003:8003 --name exonum_4 -d madt/exonum
```

3. Для каждого контейнера: перейти в директорию `./docker/example/{1,2,3,4}` и расширить права:

```
chmod 600 master.key.toml
```

4. Вернуться в `/docker` и запустить скрипт (для каждый ноды свой номер):

```
sed -i 's/\r//' run.sh
bash run.sh 0 // {0,1,2,3}
```

5. Для первой ноды выполнить:

```
sed -i 's/\r//' runWeb.sh
bash runWeb.sh
```
