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

3. Перейдите на 127.0.0.1:80, для login используйте: `demo:demo`

4. Нажмите кнопку `restart`, дождитесь завершения работы. После завершения, выполните следующий скрипт для запуска узлов в контейнерах:

```
bash runNodes.sh
```

5. Web-интерфейс доступен по адресу `localhost:8008`;

5. Наглядный пример запуска и тестирования:
   ![Alt Text](./media/madt_exonum.gif)

- Запускаем MADT;

```
sudo -HE env PYTHONPATH=$HOME/madt:$PYTHONPATH SSH_PWD=demo python3 madt_ui/main.py 80
```

- Запускаем лабораторию с заранее собранным образом:

```
sudo python3 ./lab.py
```

- Проверяем статус нашей лаборатории используя MADT UI;
- Нажимаем кнопку `restart` и ожидаем окончания работы;
- Запускаем ноды в каждом из контейнеров + web в первом контейнере с помощью скрипта `bash runNodes.sh`;
- Переходим на web-страницу по адресу `localhost:8008` и выполняем следующие действия:

```
1) Создаём два кошелька;
2) Отправляем средства с одного кошелька на второй;
3) Проверяем счёт первого кошелька;
4) Проверяем счёт второго кошелька.
```

6. Для тестирования без web-интерфейса используйте скрипт `./tests/test.sh`

## Тестирование вне Madt

1. Создадим сеть:

```
docker network create --subnet=15.0.0.0/29 PRIVATENET
```

2. Создадим 4 контейнера:

```
docker run -it --net=PRIVATENET -p 6331:6331 -p 8000:8000 -p 8008:8008 --name MADT_exonum_Node0 -d madt/exonum
docker run -it --net=PRIVATENET -p 6332:6332 -p 8001:8001 --name MADT_exonum_Node1 -d madt/exonum
docker run -it --net=PRIVATENET -p 6333:6333 -p 8002:8002 --name MADT_exonum_Node2 -d madt/exonum
docker run -it --net=PRIVATENET -p 6334:6334 -p 8003:8003 --name MADT_exonum_Node3 -d madt/exonum
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
