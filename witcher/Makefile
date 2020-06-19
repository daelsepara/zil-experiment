all: clean
	zilf -w witcher.zil
	zapf witcher.zap
	zapf -ab witcher.zap > witcher_freq.xzap
	rm witcher_freq.zap
	zapf witcher.zap
clean:
	rm -f *.xzap *.zap *.z?
