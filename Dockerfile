FROM ros:kinetic-perception

WORKDIR /workspace

RUN git clone -b aido2 https://github.com/duckietown/gym-duckietown src/gym-duckietown
RUN apt-get update
RUN easy_install pip 
RUN pip install --user -e src/gym-duckietown/
COPY . agent
RUN mv agent/dt_msg_ws dt_msg_ws
RUN apt-get install -y xvfb
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && catkin_make -j -C dt_msg_ws/"
RUN /bin/bash -c "source dt_msg_ws/devel/setup.bash"
RUN chmod u+x agent/run_display.bash
RUN pip install --user numpy --upgrade