clean:
	rm -rf output-virtualbox-iso
	#rm -rf out
	#vagrant destroy

build:
	packer build alpine-iso-install.json

add-box:
	vagrant box add alpine-clean-3.9.3 out/alpine-clean-3.9.3.box
