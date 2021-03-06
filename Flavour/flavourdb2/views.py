from django.shortcuts import render
from django.http import HttpResponse

import json

from flavourdb2.models import User, Chef, Comuna, Consumer


# Create your views here.


#main view
#	from all chefs pick foto, nombre, rating,descripcion
#		filter chefs q llegan a tu comuna


#
def mainView(request):

	idUser = int(request.GET.get('userId', -1))
	if idUser == '':
		pass #TODO return something client understands
	comuna = Consumer.objects.filter(pk=idUser)[0].comuna
	allChefs = Chef.objects.filter(comunas__name=comuna)

	print allChefs

	response_data = {}
	chef_list = []
	response_data['chefs'] = chef_list

	for chef in allChefs:
		chef_dict ={}
		chef_dict['name'] = chef.name
		chef_dict['lastname'] = chef.lastname
		chef_dict['pictureUrl'] = chef.pictureUrl
		chef_dict['description'] = chef.description
		chef_list.append(chef_dict)

	return HttpResponse(json.dumps(response_data), content_type="application/json")

def addConsumer(request):

	print request.POST
	name = request.POST.get('name')
	lastname = request.POST.get('lastname')
	address = request.POST.get('address')
	phone = request.POST.get('phone')
	FBID = request.POST.get('FBID')
	email = request.POST.get('email')
	comuna = request.POST.get('comuna')
	print comuna
	comuna = Comuna.objects.filter(name=comuna)[0]
	
	consumer = Consumer(
		name=name,
		lastname=lastname,
		address=address,
		phone=phone,
		FBID = FBID,
		email=email,
		comuna=comuna)
	try:
		consumer.save()	
	except Exception:
		return HttpResponse("failed")
	return HttpResponse("ok")

def chefs(request):

	allChefs = Chef.objects.all()

	response_data = {}
	chef_list = []
	response_data['chefs'] = chef_list

	for chef in allChefs:
		chef_dict ={}
		chef_dict['name'] = chef.name
		chef_dict['lastname'] = chef.lastname
		chef_dict['email'] = chef.email
		chef_dict['phone'] = chef.phone
		chef_dict['pictureUrl'] = chef.pictureUrl
		chef_dict['description'] = chef.description
		comunas = []
		for comuna in Comuna.objects.filter(chef=chef.pk):
			comunas.append(comuna.name)
		chef_dict['comunas'] = comunas  
		chef_list.append(chef_dict)

	return HttpResponse(json.dumps(response_data), content_type="application/json")

def index(request):


	allUsers = User.objects.all()


	#return HttpResponse("<h1>Hello, world.</h1> You're at the polls index.")
	response_data = {}
	user_list = []
	response_data['users'] = user_list

	for user in allUsers:
		user_dict ={}
		user_dict['user'] = user.name
		user_dict['surName'] = user.surName
		user_list.append(user_dict)

	return HttpResponse(json.dumps(response_data), content_type="application/json")