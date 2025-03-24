function[stress]=stress_cal(strain_cal,B,q,D_pl_stress)

strain=strain_cal(B,q);

stress=D_pl_stress*strain;

end