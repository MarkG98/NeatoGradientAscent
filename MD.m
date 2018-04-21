xLevel = 0.15;
yLevel = 0.0145;

pub = rospublisher('/raw_vel');
msg = rosmessage(pub);
sub_accel = rossubscriber('/accel');
pause(1)

threshold = 0.045;


while(abs(sub_accel.LatestMessage.Data(1)) > xLevel)
    sub_accel.LatestMessage.Data
    msg.Data = [0.07, 0.07];
    send(pub,msg);
    pause(0.01);
    while(abs(sub_accel.LatestMessage.Data(2)) > threshold)
        yMessage = sub_accel.LatestMessage.Data(2);

        if yMessage > 0
            msg.Data = [-0.05, 0.05];
            send(pub,msg);
        end

        if yMessage < 0
            msg.Data = [0.05, -0.05];
            send(pub,msg);
        end        
    end
end
msg.Data = [0,0];
send(pub,msg);