xLevel = 0.18;

pub = rospublisher('/raw_vel');

Fmsg = rosmessage(pub);
Fmsg.Data = [0.07,0.07];

TLmsg = rosmessage(pub);
TLmsg.Data = [-0.05,0.05];

TRmsg = rosmessage(pub);
TRmsg.Data = [0.05,-0.05];

Smsg = rosmessage(pub);
Smsg.Data = [0,0];

sub_accel = rossubscriber('/accel');

pause(1)

threshold = 0.035;


while(abs(sub_accel.LatestMessage.Data(1)) > xLevel)
    sub_accel.LatestMessage.Data
    send(pub,Fmsg);
    pause(0.1);
    if(abs(sub_accel.LatestMessage.Data(2)) > threshold)
        yMessage = sub_accel.LatestMessage.Data(2);

        if yMessage > 0
            while(abs(sub_accel.LatestMessage.Data(2)) > threshold)
            send(pub,TLmsg);
            end
        end

        if yMessage < 0
            while(abs(sub_accel.LatestMessage.Data(2)) > threshold)
            send(pub,TRmsg);
            end
        end        
    end
end
send(pub,Smsg);