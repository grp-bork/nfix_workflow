//move params
params.input = "s3://upload-02c5fb7c/GCA_001049335.1.genomes_clean.fa.gz"

process prodigal {

    container = "quay.io/biocontainers/prodigal:2.6.3--h516909a_2"

    input:
    path fa

    output:
    path "${fa.baseName}.prodigal.fna"

    script:
    def out_file = "${fa.baseName}.prodigal.fna"

    if (fa.name.endsWith(".gz")) {
        """
        zcat ${fa} | prodigal \
            -i /dev/stdin \
            -d ${out_file} \
            -o /dev/null \
            -p meta \
            -q
        """
    } else {
        """
        prodigal \
            -i ${fa} \
            -d ${out_file} \
            -o /dev/null \
            -p meta \
            -q
        """
    }
}

// process hmmscan {

// }

// process nfix_annotate {

// }


// Only have annotate for now
workflow {
    input_ch = prodigal(params.input)
    input_ch.view()
}