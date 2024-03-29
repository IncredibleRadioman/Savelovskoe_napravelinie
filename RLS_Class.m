classdef RLS_Class
    properties
        phi_main = 30;
        f0 = 1e9;
        ovrs = 8;
        %         fs = 8*RLS_Class.f0;
        discrete = 1;
        T_standing = 6e-5;
        tsym = 1.3e-6;
        s0 = [1, 1, 1, -1, 1];
        
        
    end
    methods
        function [x,z,outSignal,time] = getCoordinate(obj,x1,z1,Vx1,Vz1,SNR)
            
            [obj.phi_main] = 30; %������ �� �� �������
            k_phi = pi/([obj.phi_main]*pi/180/2); %����������� ��
            %�������� �����
            c = physconst('LightSpeed');
            fs = obj.ovrs*obj.f0;
            %������� ���
            %             [obj.f0] = 1e9;
            %������� �����
            %             [obj.discrete] = 1;
            %������� �������������
            %             [fs] = 8*f0;
            %����� �������
            %             [obj.T_standing] = 6e-5;
            
            %������ ���� ��
            if(z1>=0)&&(x1>=0)
                phi_true = atan(z1/x1);
            else
                if(z1>=0)&&(x1<0)
                    phi_true = pi - atan(abs(z1)/abs(x1));
                else
                    if(z1<0)&&(x1>=0)
                        phi_true = 2*pi - atan(abs(z1)/abs(x1));
                    else
                        phi_true = pi + atan(abs(z1)/abs(x1));
                    end
                end
            end
            phi = round(rad2deg(phi_true)/obj.discrete)*obj.discrete;
            phi = deg2rad(phi);
            
            if(phi == phi_true)
                a = 1;
            else
                a = abs( ( sin(k_phi*(phi_true-phi)) ) / ( ( k_phi*(phi_true-phi)) ) );
            end
            
            %�������� ���������� ����, ����� ������������ ��������
            R = sqrt(x1^2 + z1^2);
            delay = 2*R/c;
            %������� �������� ������� �������� �� ����� �����������
            v = Vx1*cos(phi) + Vz1*sin(phi);
            fd = -2*v*obj.f0/c; %������������ �������
            
            %����������� ������������������
            %             s0 = [1, 1, 1, -1, 1];
            %������������ ��������
            
            timp = obj.tsym*length(obj.s0);
            %������� ������������ �������
            t = 0:1/fs:obj.T_standing;
            signal0 = zeros(1,length(t));
            SymSamples = floor(timp*fs);
            M = length(obj.s0);
            %             tsym = obj.timp/length(s0);
            for i=1:SymSamples
                
                n = floor(t(i)/obj.tsym) + 1;
                if (n <= M)
                    signal0(i) = obj.s0(n);
                end
            end
            signal = signal0.*(exp(1i*2*pi*(obj.f0+fd).*t));
            delayN = floor(delay*fs);
            s_d = zeros(1,length(t)+delayN);
            s_d(delayN:length(t)+delayN-1) = signal;
            signal = s_d(1:length(t));
            signal = a*signal;
            
            %������ ��������� ���
            signal = awgn(signal,SNR);
            
            %������� � �������
            signal = signal.*exp(-1i*2*pi*obj.f0*t);
            
            filt = fir1(34,0.1,'low',chebwin(35,30));
            
            signal = filter(filt,1,signal);
            
            %������ �������
            Spect = fft(signal);
            
            %������� ����������� �������� ��
            freqs = -fs/2:fs/length(t):fs/2 - fs/length(t);
            Spect0 = fft(signal0);
            K = conj(Spect0).*exp(1i*2*pi*freqs*timp/2);
            
            SpectOut = Spect.*K;
            
            outSignal = (abs(ifft(SpectOut)));
            time = t;
            
            [~,idx] = max(outSignal);
            R1 = c * (idx)/fs/2;
            x = R1*cos(phi);
            z = R1*sin(phi);
        end
        
        function [x,z,Vx,Vz] = getTargetCoord(obj,speed,x0,z0,angle,t)
            
            Vx = speed * cosd(angle);
            Vz = speed * sind(angle);
            x = x0 + Vx*t;
            z = z0 + Vz*t;
            
        end
        
    end
end