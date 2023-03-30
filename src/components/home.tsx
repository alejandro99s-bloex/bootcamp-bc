import styles from '@/styles/components/Home.module.css'
import React from 'react';
import { HousesProps, User } from "../types/index";


type HomeBodyProps = {
    houses: Array<HousesProps> | undefined
    user: User | undefined
    tryToBuy: Function
}

const HomeBody: React.FC<HomeBodyProps> = ({ houses, user, tryToBuy }) => {
    console.log(houses)
    console.log(user)

    return <>
        <div className={styles.home_body}>
            {user && houses && (
                houses.map((house: HousesProps, index: number) =>
                    <div key={index} onClick={house.price < user.capacity ? () => tryToBuy(house, user) : () => { }} className={`${styles.home_body_element} ${house.price < user.capacity ? styles.home_body_element_color_approved : styles.home_body_element_color_deny}`}>
                        <img src={house.tokenUri} alt={`house_${index}`} height={60} />
                        <div><b>Nombre:</b> {house.name}</div>
                        <div><b>Precio:</b> {`$${house.price.toLocaleString('es-CO')} COP`}</div>
                        <div><b>Descripción:</b> {house.description}</div>
                    </div>
                )
            )}
        </div>
    </>
}
export default HomeBody

