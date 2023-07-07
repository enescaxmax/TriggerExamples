

/*TASK 113:Account objectinde yeni bir kayıt oluşturulduğunda, Number of 
Locations fieldına girilen değer (sayı) kadar contact olusturulmasını (Contact of 
Location 1, Contact of Location 2...)sağlayalım lütfen.



TASK 114: Öncelikle Opportunity objectinde DateTime data type inde 'Account 
Update Time' isimli bir field oluşturalım. Bir Account update edildiğinde, o 
Accountun ilgili tüm Opportunity lerinin Account Update Time fieldının bu 
updatein zamanını gösterecek şekilde assignmentını sağlayalım lütfen.



TASK 115: Bir opportunity closed won olduğunda onunla ilgili tüm tasklerin 
Statulerinin completed olmasını sağlayalım lütfen.



TASK 116: Öncelikle Name i “Batch Apex” olan (Batch Apex 1, Batch Apex 2, 
Batch Apex 3...) 300 adet  account oluşturalım.  Sonra da Asyn apex (Batch Apex)
kullanarak bu accountların ratingini “Warm” , billing City’i Ankara yapalım lütfen.



TASK 117: Asyn Apex  (Queueable apex) kullanarak,  yukarıda oluşturduğumuz 
Accountların Type fieldını ‘Prospect’ yapalım lütfen.



TASK 118: Her Pazar saat 20.30 da, isminde 'Apex' geçen Accountların 
orgumuzdan silinmesini sağlayalım lütfen.



TASK 119: Orgumuzda oluşan her yeni Accountun Rating inin Warm ve Active 
olmasını sağlayan bir Trigger yazalım ve bu triggerın amaca uygun çalısıp 
çalısmadığının kontrolünü, yazacağımız bir test class ile yapalım lütfen.



TASK 120: Bir sayının tek ya da çift sayı olduğunu bir text ile return eden bir 
method  ve bu methodun test class ını yazalım lütfen.



TASK 121: Write a trigger on the Account when the Account is updated check all 
opportunities related to the account. Update all Opportunities Stage to close lost 
if an opportunity created date is greater than 30 days from today and stage not 
equal to close won.*/
TASK 122: cars=[
    {
    id:1,
    brand:'Toyota',
    model:'Avensis',
    year:2015,
    
picLink:'https://www.carjunction.com/car_images2/40494_52366/40494_52366_2
69053.jpg' 
  },
    {
    id:2,
    brand:'Honda',
    model:'Civic',
    year:2016,
    
picLink:'https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/2017_Hond
a_Civic_EX_VTEC_CVT_1.0_Front.jpg/1920px-
2017_Honda_Civic_EX_VTEC_CVT_1.0_Front.jpg '
  },
    {
    id:3,
    brand:'Volkswagen',
    model:'Passat',
    year:2019,
    picLink:'https://cdn-ds.com/blogs-media/sites/479/2019/12/21082243/2020-
Volkswagen-Passat-Tornado-Red-B_o.png' 
  }
];                          
//Verilen objecti bir componentte for each/iterate kullanarak 
//yazdıralım lütfen
 


/*TASK 123: Oluşturacağımız bir lightning card içindeki p taglerine yazacağımız 'Bu
paragraf flag true olduğunda gösterilecek/gösterilmeyecek ' ifadesinin 
gorunmesini (okunmasını) conditional rendering yöntemini kullanarak 
sağlayalım/engelleyelim lütfen. Bu task için hardcode ile flag e değer atama 
yerine lightning input (checkbox) aracılığıyla ekranda flag değerini belirlemeye 
calısalım lütfen.



TASK 124: Bir parent bir de child olmak üzere 2 adet LWC olusturalım. 'Bu bilgi 
parentta yazıldı ve child componentte okunacak' ifadesini create ettiğimiz  parent
componentte uygun bir tagin içinde yazalım ve JS KULLANMADAN bu tagin create 
ettiğimiz child componentinden okunmasını sağlayalım lütfen. Sadece parent 
componenti orgumuza deploy edecğimizi hatırda tutalım lütfen.



TASK 125: Userdan input olarak alacağımız 2 pozitif sayının çarpımının sonucunu 
bir butona basarak görmemizi sağlayan LWC yi bir lightning card içinde create 
edelim lütfen



TASK 126: Userdan (ekrandan) alacağımız first name, last name ve title bilgilerini 
(input) kullanarak bir buton ile bir Contact recordının create edilmesini ve 
ekranda create işleminin gerçekleştiğini teyit eden bir mesajın alınmasını 
sağlayalım lutfen.



TASK 127: Parent ve Child olarak iki adet LWC olusturalım. Child componentin 
ekranından alacağımız bir city bilgisinin Parent componentin ekranında, büyük 
harflerle değiştirilmiş olarak görünmesini sağlayalım lütfen (Custom event)
TASK 128:Contact record pageinde ismi (name) ekranda gireceğimiz bir keyword 
ya da harfi içeren contactların,  bir buton yardımıyla first name, last name ve title
bilgisi ile gelmesini sağlayalım lütfen (Arama Motoru)*/