function likelihood_cont(x)
for t=1:n;
    xcurrent=x(t);
    if xcurrent<=1
        mu=0;
        sigma= sqrt(1);
        y(t)=normpdf(x(t), mu, sigma);
    else if xcurrent>=1
            mu=10;
            sigma=sqrt(3);
            y(t) = normpdf(x(t), mu, sigma);
        end
    end  
end
end