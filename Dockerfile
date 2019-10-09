FROM python:2.7
RUN apt-get -y update && \
	apt-get -y install vim-tiny jq && \
	pip install ripe-atlas-tools && \
	echo '\033[1;32;40m \nTienes todo listo para comenzar con el taller "Aprendiendo a usar las herramientas para operadores de redes de RIPE NCC"! \n\nNos vemos el miércoles 9 de Octubre a las 14:00! \n\nNo olvides completar el formulario de asistencia \nhttps://docs.google.com/forms/d/e/1FAIpQLSfxUoe0yzCojWzVXwm0OYdgLHi1h0ItTp3Oaff7E3pw4XfDqg/viewform  \033[0;37;40m\n'
