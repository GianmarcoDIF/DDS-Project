#! /bin/bash
#build the producer container

docker build -t producer:1.0 ./Producer

i=0;
t=0;
while [ $i -le 0 ];
do
    read -p "Define a topic: " topic
    export topic=$topic
    read -p "How many messages should it send about $topic? : " messagesToSend
    export messagesToSend=$messagesToSend
    read -p "Wanna use the poisson rate? (N or [int value]) : " poisson
    export poisson=$poisson
    read -p "OTHERWISE insert the message rate (msg/s) :" rate
    export rate=$rate

    read -p "How many producer do you want to create for topic $topic? : " createNumber
    for j in `seq 1 $createNumber`;
    do
        ((t=t+1+i))
        docker run -d --network host -e topic -e messagesToSend -e poisson -e rate producer:1.0
        echo "Producer number $t running and producing $messagesToSend on topic $topic"
    done
    
    read -p "Need more producer to generate? (Y/N): " go
    if [ $go == "N" ];
    then 
        ((i=i+1))
    fi
done
