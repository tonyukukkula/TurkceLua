# Başlamadan
efendim öncelikle merhabalar, kodlu modlu bir şey bakıyorsanız ![ilgili linkten](https://github.com/tonyukukkula/TurkceLua/blob/main/15dk.lua) gidip okuyabilirsiniz. Bu benioku dosyası eksik kalmış ve kalacaktır.(nokta)

# TurkceLua
Lua programlama dili uzunca zamandır ilgimi cekiyordu, simdi ogrenme vakti!!
# Başlarken
Efendim başlamadan önce birkaç şeyden bahsetmem gerek. Lua gömülebilir ve yorumlanabilir bir dildir. Brezilyalı bir abimiz tarafından geliştirilmiş olup çok tatlı ve samimidir. Lua JIT(Just-in-Time Compiler) yazım olarak Lua ile aynı olsa da JIT yorumlayıcısına/derleyicisine(Lua'da hangisi olduğunu araştırmadım ikisinden birisi :D) sahiptir ve daha hızlıdır. Lua öğrendikten sonra bu konuda bir derin-araştırma (deep dive) yapacağım, amaç şimdilik Lua öğrenmek.

* ![Buradan](https://www.lua.org/start.html) ulaşabilirsiniz, eğer hata alırsanız link şudur: https://www.lua.org/start.html
* ![Yazımı için şuraya bakabilirsiniz](https://www.lua.org/pil/contents.html), hata alırsanız link şudur: https://www.lua.org/pil/contents.html
* Dağıtımcı program olarak LuaDist kullanabilirsiniz, *npm gibi*.
* IDE olarak ZeroBraneStudio kullanabilirsiniz, devcpp'den bile sade ve daha hafif bir IDE(8mb yahu). Tasarım yeteneğim yok ama UX olarak bana bildiğim tüm geliştirme ortamlarını tokatlayabileceğini hissettirdi.

## Merhaba dünyalı!
```lua
print("Merhaba dünyalı!")
```
## İşlem Sıralaması:
Lua'da çoğu diğer programlama dillerinde var olan sıralama geçerlidir:
- Öncelikle parantez içindeki işlemler işlenir(operate)
- Sonrasında işlem önceliğine sahip işlemler halledilir(çarpma ve bölme, eğer ikisi aynı öncelik düzeyinde bulunuyorsa soldan sağa doğru işlenirler)
- En son toplama ve çıkarma işleçleri(operators) halledilir.(eğer ikisi aynı öncelik düzeyinde bulunuyorsa soldan sağa doğru işlenirler)

```lua
print(2020/6/365)     --önce: 2020/6=x  sonra:  x/365  
print(2020/(6*365))   --önce: 6*365=x   sonra:  2020/x
```

## Uç Uca Yazı Eklemek(Concatenation)
Genel olarak çok kullanılan dillerde alışkın olduğumuz *,* veya *+* operatorleri Lua'da bu iş için tanımlanmamıştır.
Bu iş için *..* tanımlıdır.

```lua
print("Merhaba" .. "dünyalı!")
```

## Print tamam da Printf yok mu yahu!?
Var canım olmaz mı! Biçim olarak daha sami hatta.
Biçimi:
- print(*(Misal %d bu bir tam sayı, misal bu da bir virgüllü sayı %0.1f)*:format(x,y))
```lua
print(('Bir günde şu kadan saat var %d 2200 saatse şu kadar gün ediyor %.1f years'):format(24, 2200/24))
```
