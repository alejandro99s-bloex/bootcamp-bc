import styles from '@/styles/components/House.module.css'
import React from 'react';
import { HousesProps } from "../types/index";

interface HomeContract {
    name: string;
    price: number;
    amountPaid: number;
}

type HomeBodyProps = {
    houses: Array<HousesProps> | undefined,
    contribute: Function
}

const HousesProfile: React.FC<HomeBodyProps> = ({ houses, contribute }) => {
    console.log(houses)
    return <>
        <div className={styles.house_body}>
            {houses && (
                houses.map((house: HousesProps, index: number) =>
                    <div key={index} onClick={()=> {}} className={`${styles.house_body_element} `}>
                        <img src={house.tokenUri} alt={`house_${index}`} height={60} />
                        <div><b>Nombre:</b> {house.name}</div>
                        <div><b>Precio:</b> {`$${house.price.toLocaleString('es-CO')} COP`}</div>
                        <div><b>Descripción:</b> {house.description}</div>
                        <button onClick={()=>contribute(house)}>Realizar aporte</button>
                        <button>Liberar leasing</button>
                    </div>
                )
            )}
        </div>
    </>
}
export default HousesProfile

