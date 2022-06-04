
GIT_BASE_URL=https://github.com/hyphae


apis-bom:
	git clone $(GIT_BASE_URL)/apis-bom.git
apis-common:
	git clone $(GIT_BASE_URL)/apis-common.git
apis-main:
	git clone $(GIT_BASE_URL)/apis-main.git
apis-ccc:
	git clone $(GIT_BASE_URL)/apis-ccc.git
apis-log:
	git clone $(GIT_BASE_URL)/apis-log.git
apis-web:
	git clone $(GIT_BASE_URL)/apis-web.git
apis-emulator:
	git clone $(GIT_BASE_URL)/apis-emulator.git
apis-main_controller:
	git clone $(GIT_BASE_URL)/apis-main_controller.git
apis-service_center:
	git clone $(GIT_BASE_URL)/apis-service_center.git
apis-tester:
	git clone $(GIT_BASE_URL)/apis-tester.git


build-apis-bom: apis-bom
	cd apis-bom/ && make install
build-apis-common:apis-common
	cd apis-common/ && make install
build-apis-main: apis-main
	cd apis-main/ && make package
build-apis-ccc: apis-ccc
	cd apis-ccc/ && make package
build-apis-log: apis-log
	cd apis-log/ && make package
build-apis-web: apis-web
	cd apis-web/ && make package
build-apis-emulator: apis-emulator
	cd apis-emulator/ && sh venv.sh
build-apis-main_controller: apis-main_controller
	cd apis-main_controller/ && sh venv.sh
build-apis-service_center: apis-service_center
	cd apis-service_center/ && sh venv.sh && sh initdb.sh
build-apis-tester: apis-tester
	cd apis-tester/ && sh venv.sh

build: build-apis-bom build-apis-common build-apis-main build-apis-ccc build-apis-log build-apis-web build-apis-emulator build-apis-main_controller build-apis-service_center build-apis-tester


update-apis-bom: apis-bom
	cd apis-bom/ && git pull
update-apis-common:apis-common
	cd apis-common/ && git pull
update-apis-main: apis-main
	cd apis-main/ && git pull
update-apis-ccc: apis-ccc
	cd apis-ccc/ && git pull
update-apis-log: apis-log
	cd apis-log/ && git pull
update-apis-web: apis-web
	cd apis-web/ && git pull
update-apis-emulator: apis-emulator
	cd apis-emulator/ && git pull
update-apis-main_controller: apis-main_controller
	cd apis-main_controller/ && git pull
update-apis-service_center: apis-service_center
	cd apis-service_center/ && git pull
update-apis-tester: apis-tester
	cd apis-tester/ && git pull

update: update-apis-bom update-apis-common update-apis-main update-apis-ccc update-apis-log update-apis-web update-apis-emulator update-apis-main_controller update-apis-service_center update-apis-tester


clean-apis-bom:
	cd apis-bom/ && make clean
clean-apis-common:
	cd apis-common/ && make clean
clean-apis-main:
	cd apis-main/ && make clean
clean-apis-ccc:
	cd apis-ccc/ && make clean
clean-apis-log:
	cd apis-log/ && make clean
clean-apis-web:
	cd apis-web/ && make clean
clean-apis-emulator:
	cd apis-emulator/ && rm -rf venv
clean-apis-main_controller:
	cd apis-main_controller/ && rm -rf venv
clean-apis-service_center:
	cd apis-service_center/ && rm -rf venv
clean-apis-tester:
	cd apis-tester/ && rm -rf venv

clean: clean-apis-bom clean-apis-common clean-apis-main clean-apis-ccc clean-apis-log clean-apis-web clean-apis-common clean-apis-bom clean-apis-emulator clean-apis-main_controller clean-apis-service_center clean-apis-tester


run-apis-main-1:
	@sh runner.sh apis-main/exe/ 'sh start.sh'
run-apis-main-2:
	@sh runner.sh apis-main/exe/ 'sh start2.sh'
run-apis-main-3:
	@sh runner.sh apis-main/exe/ 'sh start3.sh'
run-apis-main-4:
	@sh runner.sh apis-main/exe/ 'sh start4.sh'
run-apis-main: run-apis-main-1 run-apis-main-2 run-apis-main-3 run-apis-main-4
run-apis-ccc:
	@sh runner.sh apis-ccc/exe/ 'sh start.sh'
run-apis-log:
	@sh runner.sh apis-log/exe/ 'sh start.sh'
run-apis-web:
	@sh runner.sh apis-web/exe/ 'sh start.sh'
run-apis-emulator:
	@sh runner.sh apis-emulator/ '. venv/bin/activate && ./startEmul.py 4'
run-apis-main_controller:
	@sh runner.sh apis-main_controller/ '. venv/bin/activate && ./startMain.py'
run-apis-service_center:
	@sh runner.sh apis-service_center/ 'sh start.sh'
run-apis-tester:
	@sh runner.sh apis-tester/ '. venv/bin/activate && ./startTester.py'
run-mongodb:
	@sh runner.sh mongodb/ 'sh start.sh'

run: run-mongodb run-apis-service_center run-apis-emulator run-apis-main run-apis-ccc run-apis-log run-apis-web run-apis-main_controller run-apis-tester


stop-apis-main:
	cd apis-main/exe/ && sh stop-kill.sh
stop-apis-ccc:
	cd apis-ccc/exe/ && sh stop-kill.sh
stop-apis-log:
	cd apis-log/exe/ && sh stop-kill.sh
stop-apis-web:
	cd apis-web/exe/ && sh stop-kill.sh
stop-apis-emulator:
	cd apis-emulator/ && sh stop.sh
stop-apis-main_controller:
	cd apis-main_controller/ && sh stop.sh
stop-apis-service_center:
	cd apis-service_center/ && sh stop.sh
stop-apis-tester:
	cd apis-tester/ && sh stop.sh
stop-mongodb:
	cd mongodb/ && sh stop.sh

stop: stop-apis-tester stop-apis-main_controller stop-apis-main stop-apis-ccc stop-apis-log stop-apis-web stop-apis-emulator stop-apis-service_center stop-mongodb
