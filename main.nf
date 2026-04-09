process prodigal {
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

process hmmscan {
    input:
    path fa

    output:
    path "hmm_output.tbl"

    script:
    """
    hmmscan --cpu ${task.cpus} --cut_ga --tblout hmm_output.tbl ${params.hmm_profile} ${fa}
    """
}

process nfix_annotate {
    input:
    path hmm_file

    output:
    path "annotations"

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