local mus = res.bgm("dedededede.ogg")

return {
        {"bgm", "set", source=mus},
        {"bg", "add", args=res.fun.card.card(res.style.title.fontFamily, 72,
                "En este\ncliffhanger\nterminamos.")},
        mus:getDuration("seconds"),
}
