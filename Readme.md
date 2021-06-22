# Appunti lampo per scriptare GIMP
## Per GIMP 2.8
E' utile [questo tutorial](https://www.youtube.com/watch?v=J_7JZlsOb5M).

**MA ATTENZIONE**: Non esiste più il sito online con gli script, li trovi invece [in questo repository GitHub](hhttps://github.com/pixlsus/registry.gimp.org_static). Per trovare qualche script basta che navighi in ``registry.gimp.org/files`` e prendi un file tipo *.scm (sono scritti in linguaggio _Scheme_)).

## Procedura
Scarichi uno di questi script che trovi nel repo di GitHub o da un'altra parte,
li incolli nella cartella del tuo sistema corretta (vedi quale andando su GIMP>modifica>preferenze>cartelle>script) (per esempio il percorso potrebbe essere ``~/.gimp-2.8/scripts``). Poi vai su GIMP (non necessario riavvio)>filtri>script-fu>aggiorna gli script.
Dopodiche ti compare tra le diciture del menu in testa una casella con Script-Fu, ci clicchi e vedi i filtri che hai disponibili dagli script che hai caricato. Oppure li vedi nel menù dei filtri.

Se vuoi fare azioni su più immagini al colpo, puoi vedere come fare sul [sito ufficiale di GIMP](https://www.gimp.org/tutorials/Basic_Batch/).
In sintesi penso che questo comando, da terminale, sia autoesplicativo:

``` bash
gimp -i -b '(batch-unsharp-mask "image[123].png" 5.0 0.5 0)' -b '(gimp-quit 0)'
```

Ovviamente devi aver salvato uno script nella cartella adeguata (la stessa di prima) che definisce "batch-unsharp-mask".
Il codice per quello script e' questo:

``` scheme
 (define (batch-unsharp-mask pattern
                              radius
                              amount
                              threshold)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* ((filename (car filelist))
                  (image (car (gimp-file-load RUN-NONINTERACTIVE
                                              filename filename)))
                  (drawable (car (gimp-image-get-active-layer image))))
             (plug-in-unsharp-mask RUN-NONINTERACTIVE
                                   image drawable radius amount threshold)
             (gimp-file-save RUN-NONINTERACTIVE
                             image drawable filename filename)
             (gimp-image-delete image))
           (set! filelist (cdr filelist)))))
```

Puoi salvarlo con il nome che ti pare purche abbia estensione ".scm".

## Licenza e copyright
Gli script contenuti in questo repository sono ad uso personale e sono stati copiati interamente, o in parte, dal [sito web ufficiale di GIMP](https://www.gimp.org/) o da altre risorse correlate alla comunità di GIMP. Alla comunità di GIMP vanno tutti i riconoscimenti.
