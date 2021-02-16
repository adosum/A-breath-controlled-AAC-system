% for i=1:5
%     ztrain(1,i) = 1;
% end
% for i=1:5
%     ztrain(2,i+5) = 1;
% end
% for i=1:5
%     ztrain(3,i+10) = 1;
% end
% for i=1:5
%     ztrain(4,i+15) = 1;
% end
% for i=1:5
%     ztrain(5,i+20) = 1;
% end
% for i=1:5
%     ztrain(6,i+25) = 1;
% end
% for i=1:5
%     ztrain(7,i+30) = 1;
% end
% for i=1:5
%     ztrain(8,i+35) = 1;
% end
% for i=1:5
%     ztrain(9,i+40) = 1;
% end
% for i=1:5
%     ztrain(10,i+45) = 1;
% end


% text(ztrain,z,'Í¼ÐÎËµÃ÷')
% legend('Í¼Àý1','Í¼Àý2')
% plot(ztrain,'+')
% % hold on
% % plot(z,'ro')
% title('Result of the KNN classifier')
% xlabel('The serial number of the testing samples')
% ylabel('Classes')
% legend('the correct answer','result of the KNN classifier')
plotconfusion(z,ztrain);
set(findobj(gca,'type','text'),'fontsize',8) 
%colors          