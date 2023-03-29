import React, { useState } from "react";
import styles from "../styles/components/Modal.module.css";
import { MyHouse } from "../types/index";

type PopupProps = {
    show: boolean;
    myHouse: MyHouse
};

const Popup = ({ show, myHouse }: PopupProps) => {
    return show ? (
        <div className={styles.popup}>
            <div className={styles.popupContent}>
                <img src={myHouse.tokenUri} alt="" height={150} />
                <p>{myHouse.description}</p>
                <button onClick={()=>myHouse.onCancel()} className={styles.closeButton}>X</button>
                <div className={styles.buttons}>
                    <button onClick={()=>myHouse.onAccept()}>{myHouse.buttonOk}</button>
                    <button onClick={()=>myHouse.onCancel()}>{myHouse.buttonCancel}</button>
                </div>
            </div>
        </div>
    ) : null;
};

export default Popup;