extends Node2D

enum TeamName {
	PLAYER,
	ENEMY,
	STATIC
}

export (TeamName) var team = TeamName.PLAYER
