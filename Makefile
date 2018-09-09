.PHONY: all outfiles docker pdf

all: pdf docker outfiles

outfiles:
	docker rm -f salt-decon-export || true
	docker create --name salt-decon-export carsonoid/salt-decon:latest
	docker cp salt-decon-export:/srv/ ./out/
	docker rm salt-decon-export 

docker:
	docker build -t carsonoid/salt-decon:latest .

pdf:
	SOZI_OPTS="-W 30 -H 18"

	mkdir pdf || true

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/00-Intro.pdf \
	    Slides/00-Intro.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/01-Minion.pdf \
	    Slides/01-Minion.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/02-Master.pdf \
	    Slides/02-Master.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/03-Transport.pdf \
	    Slides/03-Transport.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/04-Scripts-2.pdf \
	    Slides/04-Scripts-2.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/04-Scripts-3.pdf \
	    Slides/04-Scripts-3.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/04-Scripts.pdf \
	    Slides/04-Scripts.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-1-Core.pdf \
	    Slides/05-Modules-1-Core.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-2-Data.pdf \
	    Slides/05-Modules-2-Data.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-3-Event.pdf \
	    Slides/05-Modules-3-Event.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-4-Result.pdf \
	    Slides/05-Modules-4-Result.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-5-Admin.pdf \
	    Slides/05-Modules-5-Admin.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-6-Integration.pdf \
	    Slides/05-Modules-6-Integration.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules-7-Utility.pdf \
	    Slides/05-Modules-7-Utility.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/05-Modules.pdf \
	    Slides/05-Modules.sozi.html

	sozi-to-pdf $SOZI_OPTS \
	    -o pdf/Credits.pdf \
	    Slides/Credits.sozi.html


	# Join to final out
	cd pdf
	pdftk  \
	    00-Intro.pdf \
	    01-Minion.pdf \
	    02-Master.pdf \
	    03-Transport.pdf \
	    04-Scripts-2.pdf \
	    04-Scripts-3.pdf \
	    04-Scripts.pdf \
	    05-Modules-1-Core.pdf \
	    05-Modules-2-Data.pdf \
	    05-Modules-3-Event.pdf \
	    05-Modules-4-Result.pdf \
	    05-Modules-5-Admin.pdf \
	    05-Modules-6-Integration.pdf \
	    05-Modules-7-Utility.pdf \
	    05-Modules.pdf \
	    Credits.pdf \
	    cat output Carson-Anderson_Salt-Desconstructed.pdf
