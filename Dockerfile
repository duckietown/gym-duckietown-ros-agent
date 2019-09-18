FROM osrf/ros:melodic-desktop-full-bionic

RUN git clone -b daffy https://github.com/duckietown/gym-duckietown src/gym-duckietown

RUN apt-get update \
    && apt-get install -y python3-pip python-catkin-tools  build-essential xvfb python-frozendict ffmpeg python-ruamel.yaml \
    && apt-get -y autoremove \
    && apt-get -y clean  \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install pip -U \
    && python3 -m pip install numpy scipy pandas sklearn matplotlib \
    && rm -r /root/.cache/pip

RUN apt-get install python3-pip
RUN pip3 install rospkg catkin_pkg pyyaml 



RUN pip3 install --user -e src/gym-duckietown/
COPY . agent
RUN mv agent/dt_msg_ws dt_msg_ws
RUN apt-get install -y xvfb
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin_make -j -C dt_msg_ws/"
RUN /bin/bash -c "source dt_msg_ws/devel/setup.bash"
RUN chmod u+x agent/run_display.bash
RUN pip3 install --user numpy --upgrade