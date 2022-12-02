# Αρχιτεκτονική Υπολογιστών Εργαστήριο 2


Ομάδα 3 


* Φίλιππος Τόλιας 10252
* Χρήστος-Μάριος Περδίκης 10075

### Βήμα 1ο

#### 1. Χρησιμοποιήστε τις γνώσεις σας από το πρώτο εργαστήριο και βρείτε στα σχετικά αρχεία τις βασικές παραμέτρους για τον επεξεργαστή που εξομοιώνει ο gem5 όσον αφορά το υποσύστημα μνήμης. Πιο συγκεκριμένα, βρείτε τα μεγέθη των caches (L1 instruction και L1 data caches καθώς και της L2 cache), το associativity κάθε μίας από αυτές και το μέγεθος της cache line.


Aφού δεν ορίζουμε εμείς κάποια συγκεκριμένη τιμή για το υποσύστημα μνήμης του επεξεργαστή, θα γίνει χρήση των προεπιλεγμένων τιμών από το gem5. Αυτές τις
βρίσκουμε στο αρχείο config/common/Options.py και βλέπουμε:


* `L1d cache size = 64kB`

* `L1i cache size = 32kB`

* `L2 cache size = 2MB`

* `L1d associativity = 2`

* `L1i associativity = 2`

* `L2 associativity = 8`

* `Cache line size = 64`


#### 2. Καταγράψτε τα αποτελέσματα από τα διαφορετικά benchmarks. Συγκεκριμένα κρατείστε τις ακόλουθες πληροφορίες από κάθε benchmark: (i) χρόνο εκτέλεσης (προσοχή! Το χρόνο που απαιτεί το πρόγραμμα να τρέξει στον εξομοιούμενο επεξεργαστή, όχι τον χρόνο που χρειάζεται ο gem5 να πραγματοποιήσει την εξομοίωση), (ii) CPI (cycles per instruction) και (iii) συνολικά miss rates για την L1 Data cache, L1 Instruction cache και L2 cache. Τις πληροφορίες αυτές μπορείτε να τις αντλήσετε από τα αρχεία stats.txt (Hint: για το πρώτο βρείτε την τιμή sim_seconds και για το τρίτο αναζητήστε εγγραφές σαν αυτή: icache.overall_miss_rate::total). Φτιάξτε γραφήματα που να απεικονίζουν αυτές τις πληροφορίες για το σύνολο των benchmarks. Τι παρατηρείτε;

|         | Specbzip | Specmcf | Spechmmer | Specsjeng | Speclibm |
| ------- | -------  | ------- | -------   | -------   | -------  |
| simSeconds | 0.087389 | 0.068169 | 0.064248 | 0.184545 | 0.162483 |
| CPI | 1.747783 | 1.363381 | 1.284963 | 3.690893 | 3.249665 |
| L1d total miss rate | 0.014272 | 0.003376 | 0.001865 | 0.244528 | 0.061731 |
| L1i total miss rate | 0.000061 | 0.014607 | 0.000181 | 0.016750 | 0.000088 |
| L2 total miss rate | 0.272277 | 0.158090 | 0.073000 | 0.065054 | 0.999979 |


Παρατηρούμε ότι τα benchmarks specsjeng και speclibm χρειάζονται παραπάνω χρόνο για να εκτελεστούν, έχουν μεγαλύτερο CPI, άρα χειρότερο performance και 
πιστεύουμε ότι αυτά οφείλονται στο ότι έχουν πολλά παραπάνω cache misses από τα υπόλοιπα 3 benchmarks σε όλες τις caches.


#### 3. Τρέξτε ξανά τα benchmarks στον gem5 με τον ίδιο τρόπο με προηγουμένως αλλά αυτή τη φορά προσθέστε και την παράμετρο --cpu-clock=1GHz και --cpu-clock=3GHz. Δείτε τα αρχεία stats.txt από τις τρεις εκτελέσεις του προγράμματος (την αρχική σας και αυτή με το 1GHz και το 3GHz) και εντοπίστε τις πληροφορίες για το ρολόι. Θα βρείτε δύο εισαγωγές: μία για system.clk_domain.clock και μία για cpu_cluster.clk_domain.clock. Μπορείτε να εξηγήσετε τελικά τί χρονίζεται στο 1GHz/3GHz και τί χρονίζεται στα default GHz; Γιατί πιστεύετε συμβαίνει αυτό?  Ανατρέξτε στο αρχείο config.json που αντιστοιχεί στο σύστημα με το 1GHz. Αναζητώντας πληροφορίες για το ρολόι, μπορείτε να δώσετε μια πιο σαφή απάντηση; Αν προσθέσουμε άλλον έναν επεξεργαστή, ποια εικάζετε ότι θα είναι η συχνότητα του; Παρατηρείστε τους χρόνους εκτέλεσης των benchmarks για τα συστήματα με διαφορετικό ρολόι. Υπάρχει τέλειο scaling; Μπορείτε να δώσετε μια εξήγηση αν δεν υπάρχει τέλειο scaling;


default:

* `system.clk_domain.clock = 1000`

* `system.cpu.clk_domain.clock = 500`


1GHz:

* `system.clk_domain.clock = 1000`

* `system.cpu.clk_domain.clock = 1000`


3GHz:

* `system.clk_domain.clock = 1000`

* `system.cpu.clk_domain.clock = 333`


Βλέπουμε ότι υπάρχουν δύο τιμές που αναφέρονται σε clock. Το `system.clk_domain.clock` αναφέρεται στο clock του συστήματος, το ίδιο clock που χρησιμοποιείται από όλες τις μνήμες, τα buses,
κλπ για να είναι όλα συγχρονισμένα μεταξύ τους. Το `system.cpu.clk_domain.clock` είναι το clock που χρησιμοποιείται εσωτερικά από τον επεξεργαστή μας και είναι διαφορετικό του 
system clock, αλλά παραμένει συγχρονισμένο μαζί του. Ουσιαστικά θέσαμε το clock του επεξεργαστή μας να είναι πιο γρήγορο, αλλά το clock του συστήματος παρέμεινε σταθερό στο default value. 
Υπάρχουν δυο διαφορετικά clocks γιατί υπάρχει περίπτωση ο επεξεργαστής να χρειάζεται να εκτελεί περισσότερα (καμιά φορά ίσως και λιγότερα) operations από το υπόλοιπο σύστημα. 

Επιβεβαίωση για τη θεωρία μας βλέπουμε στο αρχείο config.json. Στην κυρίως μνήμη και το bus προς τη κυρία μνήμη βλέπουμε `"clk_domain": "system.clk_domain"`, ενώ στις caches, στα bus των
caches και σε άλλα εξαρτήματα εσωτερικά του επεξεργαστή βλέπουμε `"clk_domain": "system.cpu_clk_domain".


Εικάζουμε ότι ένας νέος επεξεργαστής θα είχε το default cpu clock, δηλαδή 2GHz, καθώς υπάρχει περίπτωση να υπάρχει στη ίδιο motherboard δύο επεξεργαστές με διαφορετικές συχνότητες (πχ smartphones).


|     | 2GHz (default) | 1GHz | 3GHz |
| --- | -------------  | ---- | ---- |
| Specbzip simSeconds | 0.087389 | 0.165223 | 0.061595 |
| Specmcf simSeconds | 0.68169 | 0.132593 | 0.046799 |
| Spechmmer simSeconds | 0.064248 | 0.128175 | 0.042898 |
| Specsjeng simSeconds | 0.184545 | 0.329172 | 0.138285 |
| Speclibm simSeconds | 0.162483 | 0.246976 | 0.135953 |


Βλέπουμε ότι ενώ οι χρόνοι εκτέλεσης των τριών πρώτων benchmarks κάνουν scale, οι χρόνοι των specsjeng και speclibm όχι. Αυτό συμβαίνει διότι σε αυτά τα δύο benchmarks υπάρχουν πολλά
cache misses ειδικά στην L2, άρα ο χρόνος του προγράμματος δεν επηρεάζεται τόσο από την ταχύτητα του επεξεργαστή.

![1_2_Benchmarks](charts/1_2_Benchmarks.png)

![1_2_Benchmarks_cpi](charts/1_2_Benchmarks_cpi.png)

#### 4. Τρέξτε ξανά ένα benchmarks το οποίο θα επιλέξετε εσείς στον gem5 με τον ίδιο τρόπο με προηγουμένως αλλά αυτή τη φορά αλλάξτε το memory configuration από DDR3_1600_x64 στο DDR3_2133_x64 (DDR3 με πιο γρήγορο clock) και . Τι παρατηρείτε? Εξηγήστε τα ευρήματά σας.

Αποτελέσματα για το speclibm benchmark:

|                     | DDR3_1600_8x8 | DDR3_2133_8x8 |
| ------------------- | ------------- | ------------- |
| simSeconds          | 0.162483      | 0.15888       |
| CPI                 | 3.249665      | 3.177646      |
| L1d total miss rate | 0.061731      | 0.061731      |
| L1i total miss rate | 0.000088      | 0.000088      |
| L2 total miss rate  | 0.999979      | 0.999979      |

Αυτό που παρατηρούμε είναι ότι το σύστημα με την πιο γρήγορη RAM έχει μικρότερο `simSeconds` και `CPI` δηλαδή είναι πιο γρήγορο. Επίσης παρατηρούμε ότι τα `cache miss rate` παραμένουν ίδια. Βλέπουμε ότι δεν έχουμε μεγάλη βελτίωση στο performance διότι έχουμε πολύ μικρό L1 cache miss rate, άρα παρόλο που έχουμε πιο γρήγορη κύρια μνήμη, χρησιμοποιείται μόνο λίγες φορές.

### Βήμα 2ο

Αρχικά, θέτουμε όλες τις caches στις μέγιστες δυνατές χωρητικότητές τους, καθώς γνωρίζουμε ότι θα έχουμε το μέγιστο performance έτσι. Έπειτα μεταβάλλουμε το associativity και το cache line size της L2 και συγκρίνουμε τα cpi του κάθε benchmark. Το σκεπτικό είναι ότι η τιμή με το καλύτερο cpi θα είναι η βέλτιστη τιμή για την L2 cache και θα επαναλάβουμε την ίδια διαδικασία για L1i και L1d.

![specbzip](charts/specbzip_l2assoc.png)
![spechmmer](charts/spechmmer_l2assoc.png)
![specmcf](charts/specmcf_l2assoc.png)
![specsjeng](charts/specsjeng_l2assoc.png)
![speclibm](charts/speclimb_l2assoc.png)

(ως cache line size χρησιμοποιήσαμε το default)

Το CPI μειώνεται στην αρχή όταν αυξάνουμε το association και μετά ξανά ανεβαίνει.
Αυτό γίναιται επιδή με association μεγαλύτερο του 1 δεν διαγράφονται τυχόν χρίσημα δεδομένα απο την cache αρά μιώνονται τα cache misses.
Ο λόγος που μετα αυξάνει το CPI είναι ότι αυξάνει το access time.

Παρατηρούμε ότι για associativity = 2 έχουμε το καλύτερο performance σε όλα τα benchmarks (περιέργως στο spechmmer δεν έχει σημασία τι associativity χρησιμοποιούμε). Κρατάμε την τιμή αυτή σταθερή και προχωράμε στο cache line size της L2.

![specbzip](charts/specbzip_cache_line.png)
![spechmmer](charts/spechmmer_cache_line.png)
![specmcf](charts/specmcf_cache_line.png)
![specsjeng](charts/specsjeng_cache_line.png)
![speclibm](charts/speclibm_cache_line.png)

Στα benchmarks με καλή τοπικότητα, το μεγάλο cache line size βελτιώνει το performance του προγράμματος, ενώ σε προγράμματα με κακή τοπικότητα το χειροτερεύει, καθώς πρέπει να γράφει μεγαλύτερα blocks μνήμης από την RAM στις caches.
