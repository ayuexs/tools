


#旧
UPDATE officer_prototype b LEFT JOIN officer a ON b.id = a.pro_id LEFT JOIN equipment c ON b.id = c.officer_id LEFT JOIN equipment_prototype d on c.pro_id = d.id
SET a.power = floor
      ((POWer(  
          (floor(b.valor +((0.3*a.`level`+4)*b.quality+(0.4*a.`level`+3)*a.star+0.5*a.`level`)*b.valor_growth/100+IFNULL(d.valor,0.0)) *0.04-1)*
          (floor(b.Toughness+((0.3*a.`level`+4)*b.quality+(0.4*a.`level`+3)*a.star+0.5*a.`level`)*b.Toughness_growth/100+IFNULL(d.toughness,0.0)) *0.04-1)*
          (floor(b.Intelligence+((0.3*a.`level`+4)*b.quality+(0.4*a.`level`+3)*a.star+0.5*a.`level`)*b.Intelligence_growth/100+IFNULL(d.intelligence,0.0)) *0.04-1)*
          (floor(b.Perception+((0.3*a.`level`+4)*b.quality+(0.4*a.`level`+3)*a.star+0.5*a.`level`)*b.Perception_growth/100+IFNULL(d.perception,0.0)) *0.04-1)
        ,0.16667)-1)*50*
          (floor(b.leadership+((0.3*a.`level`+4)*b.quality+(0.4*a.`level`+3)*a.star+0.5*a.`level`)*b.leadership_growth/100+IFNULL(d.leadership,0.0)))
      );

#新
#总基础值 = 军官基础值 + （品质+7）*星级*属性基础参数
#总成长值 = （1-（10-品质）*（5-星级）/60）*属性成长参数*军官成长值/100*等级
#军官属性 = 总基础值+总成长值;（四舍五入，适用五项属性）
UPDATE officer a LEFT JOIN officer_prototype b ON a.pro_id = b.id 
SET a.power = floor
      ((POWER(  
          (ROUND(b.valor+(b.quality+7)*a.star*0.5+(1-(10-b.quality)*(5-a.star)/60)*1.5*b.valor_growth/100*a.`level`)*0.04-1)*
          (ROUND(b.toughness+(b.quality+7)*a.star*0.5+(1-(10-b.quality)*(5-a.star)/60)*1.5*b.toughness_growth/100*a.`level`)*0.04-1)* 
          (ROUND(b.intelligence+(b.quality+7)*a.star*0.5+(1-(10-b.quality)*(5-a.star)/60)*1.5*b.intelligence_growth/100*a.`level`)*0.04-1)* 
          (ROUND(b.perception+(b.quality+7)*a.star*0.5+(1-(10-b.quality)*(5-a.star)/60)*1.5*b.perception_growth/100*a.`level`)*0.04-1)
        ,0.16667)-1)*50*
          ROUND(b.leadership+(b.quality+7)*a.star*2.5+(1-(10-b.quality)*(5-a.star)/60)*15*b.leadership_growth/100*a.`level`)
      );
  