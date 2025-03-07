// Any significant russian texts should be loaded from outside of sourcecode

GLOBAL_LIST_INIT(hallucination_phrases, world.file2list("code/modules/mob/living/carbon/hallucination_phrases.txt"))

// Things Poly randomly says
GLOBAL_LIST_INIT(poly_phrases, world.file2list("code/modules/mob/living/simple_animal/friendly/poly_phrases.txt"))

proc/load_phrases_medbot(file)
    var/list/phrases = list()
    var/text = file2text(file)
    if (!text)
        return phrases
    for (var/line in splittext(text, "\n"))
        var/list/data = splittext(line, "=")
        if (length(data) == 2)
            phrases[data[1]] = data[2]
    return phrases
