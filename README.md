# Autonomous Power Interchange System (APIS)

# APIS features  
By accommodating P2P energy sharing between distributed batteries, it is possible to build a microgrid that utilizes variable renewable energy(VRE) as the main power source and enhances the resilience of the power system. These distributed batteries absorb fluctuations of VRE generation and improve community self-sufficiency by balancing supply and demand within the community. 
 <br />  
Click [here](https://www.sonycsl.co.jp/tokyo/11481/) for details
 <br />  
# Technoogy

## Physical Peer to Peer(PP2P) energy sharing
This technology achieves a fixed amount of energy sharing between batteries by constant current control. It offset a shortage of one battery with delivering the necessary amount from a surplus of other battery. It is possible to send a fixed amount of power between specific users (batteries), which was difficult to realize by the voltage control, and it is possible to transact PP2P energy trading between users on the condition of the required energy amount and energy price. 

![キャプチャ](https://user-images.githubusercontent.com/71874910/95694571-c0c47080-0c6d-11eb-9935-89d62e43228c.PNG)

## Autonomous distributed control
Software with the same functions is installed in each battery system, and the software implements energy sharing according to the transaction conditions (time window, energy amount, energy price, etc.) of each battery system. It is a flexible energy trading system that allows various transaction conditions to be set for each battery system and that the conditions can be dynamically changed for each time window. 

![キャプチャ](https://user-images.githubusercontent.com/71874910/95833927-3ff19b80-0d77-11eb-9bc7-1994e641d5fd.PNG)

 <br />  
 <br />  

## Software  
The software that realizes the above technology and makes it possible to easily construct a DC microgrid is released.  

### ▼ Software required to simulate energy exchange using a hardware emulator 
 - [apis-main](https://github.com/hyphae/apis-main)  
  Software installed on each node to provide bi-directional energy exchange with autonomous decentralized control   
  See apis-main's [Documentation](https://github.com/hyphae/apis-main/blob/master/doc/en/apis-main_specification_en.md) for more information.  
 - [apis-main_controller](https://github.com/hyphae/apis-main_controller)   
  Software that visualizes the status of apis-main installed on each node and the status of energy exchange between nodes  
  See apis-main_controller's [Documentation](https://github.com/hyphae/apis-main_controller/blob/master/doc/en/apis-main-controller_specification_en.md) for more information. 
 - [apis-web](https://github.com/hyphae/apis-web)  
  Software that acquires necessary information for visualization from apis-main and provides it to apis-main_controller  
  See apis-web's [Documentation](https://github.com/hyphae/apis-web/blob/master/doc/en/apis-web_specification_en.md) for more information. 
 - [apis-emulator](https://github.com/hyphae/apis-emulator)  
  Software to emulate hardware such as DC/DC converters and batteries   
  See apis-emulator's [Documentation](https://github.com/hyphae/apis-emulator/blob/master/doc/en/apis-emulator_specification_en.md) for more information.  
 - [apis-service_center](https://github.com/hyphae/apis-service_center)  (Added on December 24, 2020)  
  Software to provide information required by the administrators and users of clusters constructed of apis-main services installed in each unit.  
  See apis-service_center's [Documentation](https://github.com/hyphae/apis-service_center/blob/main/doc/en/apis-service_center_specification_EN.md) for more information.  
 - [apis-ccc](https://github.com/hyphae/apis-ccc)  (Added on December 24, 2020)  
  Software to uploade information that is related to energy sharing to apis-service_center.  
  See apis-ccc's [Documentation](https://github.com/hyphae/apis-ccc/blob/main/doc/en/apis-ccc_specification_EN.md) for more information. 
 - [apis-log](https://github.com/hyphae/apis-log)  (Added on December 24, 2020)  
  Software to receive information from apis-main by multicast via a communication line and storing that information in a database.  
  See apis-log's [Documentation](https://github.com/hyphae/apis-log/blob/main/doc/en/apis-log_specification_EN.md) for more information. 
 - [apis-tester](https://github.com/hyphae/apis-tester)  (Added on December 24, 2020)  
  Software to test and evaluation of apis-main.  
  See apis-tester's [Documentation](https://github.com/hyphae/apis-tester/blob/main/doc/en/apis-tester_specification_EN.md) for more information. 
  
 ## Installation  
 
  [Operating Environment]  
  The above software has been tested on the following operating systems.  
  - Ubuntu 18.04, 20.04  
  - CentOS 7, 8   
  - macOS Catalina, Big Sur
 
 　* Virtual environments are not supported.  
 
 [Preparation]   
  It is assumed that the necessary software are installed.    
  The following is an example of an advance preparation for Ubuntu 18.04.   
  * Install the JDK if it's not already installed.   
  * Python3.6.9 or later is required. 
  * Sqlite3.8.3 or later is required. (CentOS 7)
  
```bash
$ sudo apt install git
$ sudo apt install make
$ sudo apt install maven
$ sudo apt install groovy
$ sudo apt install python3-venv
$ sudo apt install python3-pip
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
$ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
$ sudo apt install mongodb-org
```

[APIS related software bach installation]  
 Install all of the above APIS related software at one time.   
 See each software repository for the individual installation and execution of each software.    
 
 ```bash
$ git clone https://github.com/hyphae/APIS.git
$ cd APIS
$ make build
```

* If an error occurs with the "make build" or "make run" command, open the terminal again and run it.  
 
## Running  
Run all of the above APIS related software at once.    

 ```bash
$ make run
```

 &emsp;After running each software, access the followings in your browser to display.   
 
 &emsp; &emsp; 0.0.0.0:4382/  &emsp; -> apis-main_controller  
 &emsp; &emsp; 0.0.0.0:4390/  &emsp; -> apis-emulator   
 &emsp; &emsp; 0.0.0.0:10000/ &emsp; -> apis-tester  
 &emsp; &emsp; http://127.0.0.1:8000/static/ui_example/staff/visual.html   &emsp; -> apis-service_center (account/pwd = admin/admin)  
 
  <br />  
 
  &emsp;The following picture is apis-main_controller.
  &emsp;Flash an cache once.
 
 ![キャプチャ](https://user-images.githubusercontent.com/71874910/97250475-602a5b80-1849-11eb-95bd-b8c1cac57c61.PNG)
 
 &emsp;Simulate energy exchange with setting Global Mode to "Run".  
 
 ![キャプチャ](https://user-images.githubusercontent.com/71874910/96272423-0932b400-1009-11eb-9a90-f9e5bd49baef.PNG)
 
 <br />  
 
 
 ## Stopping
Stop all of the above APIS related software at once.   

 ```bash
$ make stop
```
  
### ▼ Software and hardware information required for energy exchange using actual DC/DC converters and batteries
Use apis-dcdc_batt_comm instead of apis-emulator.  
 
 - [apis-dcdc_batt_comm](https://github.com/hyphae/apis-dcdc_batt_comm)  
  Sample device driver to control DC/DC converters and  batteries    
  See apis-dcdc_batt_comm's [Documentation](https://github.com/hyphae/apis-dcdc_batt_comm/blob/master/doc/en/apis-dcdc_batt_comm_specification_en.md) for more information.  
 - [apis-build_version_up_system](https://github.com/hyphae/apis-build_version_up_system)  
 This tool clones all of the software needed to build the APIS evaluation environment from GitHub/hyphae in a single batch, builds the software, generates the various configuration files required for APIS operation according to the configuration file, and then installs all of the software on multiple nodes.
  See apis-build_version_up_systems's [Documentation](https://github.com/hyphae/apis-build_version_up_system/blob/main/doc/en/apis-build_version_up_system_specification_EN.md) for more information.  
 - [apis-hw-info](https://github.com/SonyCSL/apis-hw-info)  
  Hardware reference information  
  See apis-hw-info's [Documentation](https://github.com/hyphae/apis-hw-info/blob/main/MAIN-DOCUMENT_EN.md) for more information.

 ## License
&emsp;[Apache License Version 2.0](https://github.com/hyphae/APIS/blob/master/LICENSE)


## Notice
&emsp;[Notice](https://github.com/hyphae/APIS/blob/master/NOTICE.md)
