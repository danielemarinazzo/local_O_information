% Local o-information in a Ising Model
clear;clc;


N = 3;   % Number of spin

coupling = -1:0.01:1; m = length(coupling);
for j = 1:m
    J = coupling(j);
    J12 = J; J13 = J; J23 = J; JJ = 0; % -J
    
    p = zeros(2,2,2);
    %
    for s1=0:1
        for s2=0:1
            for s3=0:1
                q1 = 2*s1-1; q2 = 2*s2-1; q3 = 2*s3-1;
                a = J12*q1*q2+J13*q1*q3+J23*q2*q3+JJ*q1*q2*q3;
                p(s1+1,s2+1,s3+1) = exp(a);
            end
        end
    end

    p = p/sum(p(:));
    
    
    p12 = squeeze(sum(p,3));
    p13 = squeeze(sum(p,2));
    p23 = squeeze(sum(p,1));
    p1  = squeeze(sum(p12,2));
    p2  = squeeze(sum(p12,1));
    p3  = squeeze(sum(p23,1));
    
    % Here we calculate entropies from p
    for s1=1:2
        for s2=1:2
            for s3=1:2
                if p(s1,s2,s3) >0
                    h(s1,s2,s3) = -log(p(s1,s2,s3));
                else
                    h(s1,s2,s3)=0;
                end
            end
        end
    end
    
    for q=1:2
        for r=1:2
            %
            if p12(q,r) >0
                h12(q,r)=-log(p12(q,r));
            else
                h12(q,r)=0;
            end
            %
            if p13(q,r) >0
                h13(q,r)=-log(p13(q,r));
            else
                h13(q,r)=0;
            end
            %
            if p23(q,r) >0
                h23(q,r)=-log(p23(q,r));
            else
                h23(q,r)=0;
            end
            %
        end
    end
    
    for q=1:2
        %
        if p1(q) >0
            h1(q)=-log(p1(q));
        else
            h1(q)=0;
        end
        %
        if p3(q) >0
            h3(q)=-log(p3(q));
        else
            h3(q)=0;
        end
        %
        if p2(q) >0
            h2(q)=-log(p2(q));
        else
            h2(q)=0;
        end
        %
    end
    
    
    % Now we calculate local o-information for each state (s1,s2,s3)
    for s1=1:2
        for s2=1:2
            for s3=1:2
                o(s1,s2,s3) = (N-2)*h(s1,s2,s3) + ...
                              (h1(s1)-h23(s2,s3))+(h2(s2)-h13(s1,s3))+(h3(s3)-h12(s1,s2));
            end
        end
    end
    % Here we calculate the average of local o-information
    ooo=0;
    for s1=1:2
        for s2=1:2
            for s3=1:2
                ooo=ooo+p(s1,s2,s3)*o(s1,s2,s3);
            end
        end
    end
    oo(j,1:2,1:2,1:2) = o;
    omean(j) = ooo;
end
oloc = reshape(oo,m,8);

%% Figure
figure('Name','Toy Model','Position',[489.0000  119.4000  640.8000  644.0000],'Color','w')
col = lines(3);

subplot(3,1,1)
plot(coupling,omean,'k','LineWidth',1.25);ylabel('\Omega','FontSize',26); xlabel("Coupling coefficient (J)"+newline+"   "); hold on
scatter(coupling(1),omean(1),30,col(1,:),'filled')
scatter(coupling(end),omean(end),30,col(2,:),'filled')
grid on

subplot(3,1,2);
plot(oloc(end,:),'o','MarkerSize',8,'Color',col(2,:),'LineWidth',2),title('Non-frustrated system (J=1)')
xlim([0.5 8.5]);ylim([-2.3 1]);ylabel('\omega','FontSize',26);xlabel('spin configuration')
xticks([1 2 3 4 5 6 7 8]); grid on
xticklabels({'\downarrow \downarrow \downarrow','\downarrow \downarrow \uparrow','\downarrow \uparrow \downarrow','\downarrow \uparrow \uparrow','\uparrow \downarrow \downarrow','\uparrow \downarrow \uparrow','\uparrow \uparrow \downarrow','\uparrow \uparrow \uparrow'})

subplot(3,1,3)
plot(oloc(1,:),'o','MarkerSize',8,'Color',col(1,:),'LineWidth',2),title('Frustrated system (J=-1)')
xlim([0.5 8.5]);ylim([-0.5 3]);ylabel('\omega','FontSize',26);xlabel('spin configuration')
xticks([1 2 3 4 5 6 7 8]); grid on
xticklabels({'\downarrow \downarrow \downarrow','\downarrow \downarrow \uparrow','\downarrow \uparrow \downarrow','\downarrow \uparrow \uparrow','\uparrow \downarrow \downarrow','\uparrow \downarrow \uparrow','\uparrow \uparrow \downarrow','\uparrow \uparrow \uparrow'})

