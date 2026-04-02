//move params
params.input = "s3://upload-02c5fb7c/GCA_001049335.1.genomes_clean.fa.gz"
params.hmm_profile = "/vol/data/databases/clowm/CLDB-019d446b8a2e7fb8b797a2b3b819c485/latest/src/nfixplanet/reference_data/hmm_profiles/nfixplanet_models.hmm"

process prodigal {
    input:
    path fa

    output:
    path "${fa.baseName}.prodigal.fna"

    container "quay.io/biocontainers/prodigal:2.6.3--h516909a_2"

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

process hmmscan {
    input:
    path fa

    output:
    path "hmm_output.tbl"

    container "quay.io/biocontainers/hmmer:3.4--hdbdd923_1"

    //TODO: test after resources are added to clowm

    script:
    """
    ls /vol/data/databases/clowm/CLDB-019d446b8a2e7fb8b797a2b3b819c485/latest/ > hmm_output.tbl
    # hmmscan --cpu 4 --cut_ga --tblout hmm_output.tbl ${params.hmm_profile} ${fa}
    """
}

process nfix_annotate {
    input:
    path hmm_file

    output:
    path annotations

    //TODO: add publish dir

    container "mahdirobbani/nfixplanet:0.1.6"

    script:
    """
    nfixplanet annotate --input_hmms ${hmm_file} --output_directory annotations
    """
}


workflow {
    input_ch = prodigal(params.input)
    hmm_ch = hmmscan(input_ch)
    nfix_annotate(hmm_ch)
}