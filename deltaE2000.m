function de00 = deltaE2000(image, KLCH)

% The optional argument KLCH is a 1x3 vector containing the
% the value of the parametric weighting factors kL, kC, and kH
% these default to 1 if KLCH is not specified.


de00 = [];

% Parametric factors 
if (nargin <3 ) 
     % Values of Parametric factors not specified use defaults
     kl = 1; kc=1; kh =1;
else
     % Use specified Values of Parametric factors
     if ( (size(KLCH,1) ~=1) | (size(KLCH,2) ~=3))
       disp('deltaE00: KLCH must be a 1x3  vector');
       return;
    else
       kl =KLCH(1); kc=KLCH(2); kh =KLCH(3);
     end
end

L = image( :, :,1);
Lmin=min(min(L));
a = image( :, :,2)';
amin=min(min(a));
b = image( :, :,3);
bmin=min(min(b));
Cmin = sqrt(amin.^2+bmin.^2);

Lmax = max(max(L));
amax = max(max(a));
bmax = max(max(b));
Cmax = sqrt(amax.^2+bmax.^2);
 
Cmean = (Cmin + Cmax)/2;

G = 0.5* ( 1 - sqrt( (Cmean.^7)./(Cmean.^7 + 25^7)));

apmin = (1+G).*amin;
apmax = (1+G).*amax; 
Cpmax = sqrt(apmax.^2+bmax.^2);
Cpmin = sqrt(apmin.^2+bmin.^2);
% Compute product of chromas and locations at which it is zero for use later
Cpprod = (Cpmax.*Cpmin);
zcidx = find(Cpprod == 0);


% Ensure hue is between 0 and 2pi
% NOTE: MATLAB already defines atan2(0,0) as zero but explicitly set it
% just in case future definitions change
hpmin = atan2(bmin,apmin);
hpmin = hpmin+2*pi*(hpmin < 0);  % rollover ones that come -ve
hpmin(find( (abs(apmin)+abs(bmin))== 0) ) = 0;
hpmax = atan2(bmax,apmax);
hpmax = hpmax+2*pi*(hpmax < 0);
hpmax(find( (abs(apmax)+abs(bmax))==0) ) = 0;

dL = (Lmax-Lmin);
dC = (Cpmax-Cpmin);
% Computation of hue difference
dhp = (hpmax-hpmin);
dhp = dhp - 2*pi* (dhp > pi );
dhp = dhp + 2*pi* (dhp < (-pi) );
% set chroma difference to zero if the product of chromas is zero
dhp(zcidx ) = 0;

% Note that the defining equations actually need
% signed Hue and chroma differences which is different
% from prior color difference formulae

dH = 2*sqrt(Cpprod).*sin(dhp/2);
%dH2 = 4*Cpprod.*(sin(dhp/2)).^2;

% weighting functions
Lp = (Lmax+Lmin)/2;
Cp = (Cpmin+Cpmax)/2;
% Average Hue Computation
% This is equivalent to that in the paper but simpler programmatically.
% Note average hue is computed in radians and converted to degrees only 
% where needed
hp = (hpmin+hpmax)/2;
% Identify positions for which abs hue diff exceeds 180 degrees 
hp = hp - ( abs(hpmin-hpmax)  > pi ) *pi;
% rollover ones that come -ve
hp = hp+ (hp < 0) *2*pi;
% Check if one of the chroma values is zero, in which case set 
% mean hue to the sum which is equivalent to other value
hp(zcidx) = hpmax(zcidx)+hpmin(zcidx);

Lpm502 = (Lp-50).^2;
Sl = 1 + 0.015*Lpm502./sqrt(20+Lpm502);  
Sc = 1+0.045*Cp;
T = 1 - 0.17*cos(hp - pi/6 ) + 0.24*cos(2*hp) + 0.32*cos(3*hp+pi/30) ...
    -0.20*cos(4*hp-63*pi/180);
Sh = 1 + 0.015*Cp.*T;
delthetarad = (30*pi/180)*exp(- ( (180/pi*hp-275)/25).^2);
Rc =  2*sqrt((Cp.^7)./(Cp.^7 + 25^7));
RT =  - sin(2*delthetarad).*Rc;

klSl = kl*Sl;
kcSc = kc*Sc;
khSh = kh*Sh;

% The CIE 00 color difference
de00 = sqrt( (dL./klSl).^2 + (dC./kcSc).^2 + (dH./khSh).^2 + RT.*(dC./kcSc).*(dH./khSh) );

return
